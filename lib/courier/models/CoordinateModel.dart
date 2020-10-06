import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:optima_delivery_mobile/common/helpers/api.dart';
import 'package:optima_delivery_mobile/common/helpers/geolocation.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/common/models/LocationPermissionModel.dart';
import 'package:optima_delivery_mobile/courier/types/CourierTypes.dart';

const int defaultTimerDuration = 5;
const timeout = Duration(seconds: defaultTimerDuration);

class CoordinateModel {
  static final Geolocation _geolocation = Geolocation();
  static Timer _timer;
  static bool _isPermissionRequested = false;
  static LoadingStatuses loadingStatus = LoadingStatuses.untouched;
  static ValueNotifier<LocationPermissionModel> locationPermissionModel =
      ValueNotifier(LocationPermissionModel(false));
  final Courier _courier;

  CoordinateModel(this._courier) {
    if (_courier != null) {
      tryInitDependencies();
    }
  }

  void tryInitDependencies() {
    if (!locationPermissionModel.value.isLocationPermissionGranted) {
      _geolocation.checkGeolocationStatusGranted().then((isGranted) {
        if (isGranted) {
          locationPermissionModel.value = LocationPermissionModel(true);
          startTimer();
        } else {
          if (!_isPermissionRequested) {
            _isPermissionRequested = true;

            _geolocation.requestGeolocationPermission().then((isGranted) {
              _isPermissionRequested = false;

              if (isGranted) {
                locationPermissionModel.value = LocationPermissionModel(true);
                startTimer();
              }
            });
          }
        }
      });
    } else {
      startTimer();
    }
  }

  void startTimer() {
    if (_courier != null && _courier.isOnShift) {
      _timer ??= Timer.periodic(timeout, _handleTick);
    } else {
      stopTimer();
    }
  }

  void stopTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  void _handleTick(Timer timer) async {
    final coordinates = await _geolocation.getCurrentPosition();
    if (coordinates != null) {
      setCoordinate(coordinates);
    }
  }

  Future<Map<String, dynamic>> _fetchSetCoordinates(Position coordinates) {
    return api.put('/api/v1/couriers/self/coordinates', body: {
      'lat': coordinates.latitude.toString(),
      'lon': coordinates.longitude.toString(),
    });
  }

  void setCoordinate(Position coordinates) async {
    loadingStatus = LoadingStatuses.loading;
    final response = (await _fetchSetCoordinates(coordinates));
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
