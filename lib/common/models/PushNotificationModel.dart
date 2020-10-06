import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:optima_delivery_mobile/common/helpers/api.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/courier/models/CourierModel.dart';
import 'package:optima_delivery_mobile/delivery/models/DeliveryModel.dart';

class PushNotificationsModel {
  final _storage = FlutterSecureStorage();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static bool _initialized = false;
  final CourierModel _courierModel;
  final DeliveryModel _deliveryModel;
  static LoadingStatuses loadingStatus = LoadingStatuses.untouched;
  static String deviceToken;
  final onTokenRefreshController = StreamController();

  PushNotificationsModel(this._courierModel, this._deliveryModel);

  Future<Map<String, dynamic>> _fetchSetToken(String token) {
    return api.post('/api/v1/couriers/self/fcm-token', body: {
      'token': token,
    });
  }

  Future<Map<String, dynamic>> _fetchDeleteToken(String token) {
    return api.delete('/api/v1/couriers/self/fcm-token', params: {
      'token': token,
    });
  }

  void handleMessageArrived(Map<String, dynamic> message) {
    if (message['data'] != null &&
        message['data']['type'] != null &&
        _deliveryModel != null) {
      final id = message['data']['deliveryId'];
      final idInt = id is String ? int.parse(id) : id as int;

      switch (message['data']['type'] as String) {
        case 'courierOnline':
          {
            if (_courierModel != null &&
                !(_courierModel.item != null &&
                    _courierModel.item.isOnShift == true)) {
              _courierModel.loadProfile();
            }

            if (_deliveryModel.deliveriesStatus == 'notOnShift') {
              _deliveryModel.loadList();
            }
            break;
          }
        case 'courierOffline':
          {
            if (_courierModel != null &&
                !(_courierModel.item != null &&
                    _courierModel.item.isOnShift == false)) {
              _courierModel.loadProfile();
            }

            if (_deliveryModel.deliveriesStatus != 'notOnShift') {
              _deliveryModel.loadList();
            }
            break;
          }
        case 'newDeliveries':
          {
            _deliveryModel.clear();
            _deliveryModel.loadList();

            break;
          }
        case 'deliveryCanceled':
          {
            _deliveryModel.clear();
            _deliveryModel.loadList().then((_) {
              if (idInt != null) {
                _deliveryModel.loadItem(idInt);
              }
            });

            break;
          }
        case 'deliveryUpdated':
          {
            if (idInt != null) {
              _deliveryModel.loadItem(idInt);
            }
            break;
          }
      }
    }
  }

  void init() async {
    if (!_initialized) {
      await _firebaseMessaging.requestNotificationPermissions();

      deviceToken = await _storage.read(key: 'pushToken');

      _firebaseMessaging.onTokenRefresh.listen(_handleTokenRefreshed);

      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          handleMessageArrived(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          handleMessageArrived(message);
        },
        onResume: (Map<String, dynamic> message) async {
          handleMessageArrived(message);
        },
      );

      _initialized = true;
    } else {
      await _handleTokenRefreshed(deviceToken);
    }
  }

  Future<void> _handleTokenRefreshed(String newToken) async {
    // Нет смысла выолнять долгую операцию, если значение не поменялось.
    if (deviceToken != newToken) {
      await _storage.write(key: 'pushToken', value: newToken);
    }

    if (deviceToken != null) {
      await deleteToken();
    }

    deviceToken = newToken;
    await setToken();
  }

  Future<void> setToken() async {
    loadingStatus = LoadingStatuses.loading;

    final response = (await _fetchSetToken(deviceToken));
    final responseMessages = response['message'] as List<dynamic>;

    if (response['code'] == 401) {
      loadingStatus = LoadingStatuses.noAuthorize;
    } else if (responseMessages == null || response['code'] as int >= 500) {
      loadingStatus = LoadingStatuses.noConnection;
    } else if (responseMessages.isNotEmpty) {
      loadingStatus = LoadingStatuses.failed;
    } else {
      loadingStatus = LoadingStatuses.finished;
    }
  }

  Future<void> deleteToken() async {
    loadingStatus = LoadingStatuses.loading;

    final response = (await _fetchDeleteToken(deviceToken));
    final responseMessages = response['message'] as List<dynamic>;

    if (response['code'] == 401) {
      loadingStatus = LoadingStatuses.noAuthorize;
    } else if (responseMessages == null || response['code'] as int >= 500) {
      loadingStatus = LoadingStatuses.noConnection;
    } else if (responseMessages.isNotEmpty) {
      loadingStatus = LoadingStatuses.failed;
    } else {
      loadingStatus = LoadingStatuses.finished;
    }
  }
}
