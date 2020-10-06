import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/helpers/api.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/courier/types/CourierTypes.dart';

enum CourierLoadType {
  autoSign,
  sign,
  profile,
}

class CourierModel extends ChangeNotifier {
  LoadingStatuses signLoadingStatus = LoadingStatuses.untouched;
  LoadingStatuses autoSignLoadingStatus = LoadingStatuses.untouched;
  LoadingStatuses profileLoadingStatus = LoadingStatuses.untouched;
  LoadingStatuses inWarehouseLoadingStatus = LoadingStatuses.untouched;
  Courier item;

  Future<Map<String, dynamic>> _fetchItem() {
    return api.get('/api/v1/couriers/profile', params: {
      'links': ['warehouse', 'vehicle']
    });
  }

  Future<Map<String, dynamic>> _fetchSetInWarehouse() {
    return api.put('/api/v1/couriers/self/in-warehouse');
  }

  Future<void> logout() async {
    item = null;
    signLoadingStatus = LoadingStatuses.untouched;
    autoSignLoadingStatus = LoadingStatuses.untouched;
    notifyListeners();
    await api.deleteToken();
  }

  Future<bool> autoSignIn() async {
    final code = await api.getToken();

    if (code != null) {
      final isSuccess =
          await loadProfile(courierLoadType: CourierLoadType.autoSign);
      return isSuccess;
    }
    return null;
  }

  Future<bool> signIn(String code) async {
    await api.setToken(code);
    final isSuccess = await loadProfile(courierLoadType: CourierLoadType.sign);

    return isSuccess;
  }

  void _setStatus(LoadingStatuses status, CourierLoadType courierLoadType) {
    if (courierLoadType == CourierLoadType.autoSign) {
      autoSignLoadingStatus = status;
    } else if (courierLoadType == CourierLoadType.sign) {
      signLoadingStatus = status;
    } else {
      profileLoadingStatus = status;
    }
  }

  LoadingStatuses _getStatus(CourierLoadType courierLoadType) {
    if (courierLoadType == CourierLoadType.autoSign) {
      return autoSignLoadingStatus;
    } else if (courierLoadType == CourierLoadType.sign) {
      return signLoadingStatus;
    }

    return profileLoadingStatus;
  }

  Future<bool> loadProfile(
      {CourierLoadType courierLoadType = CourierLoadType.profile}) async {
    _setStatus(LoadingStatuses.loading, courierLoadType);
    final response = (await _fetchItem());
    final responseMessages = response['message'] as List<dynamic>;

    if (response['code'] == 401) {
      _setStatus(LoadingStatuses.noAuthorize, courierLoadType);
    } else if (responseMessages == null || response['code'] as int >= 500) {
      _setStatus(LoadingStatuses.noConnection, courierLoadType);
    } else if (responseMessages.isNotEmpty) {
      _setStatus(LoadingStatuses.failed, courierLoadType);
    } else {
      final responseData = response['data'] as Map<String, dynamic>;
      final responseProfile = responseData['profile'] as Map<String, dynamic>;
      final responseWarehouse =
          responseData['warehouse'] as Map<String, dynamic>;
      final responseVehicle = responseData['vehicle'] as Map<String, dynamic>;

      final courier = Courier.fromJson(responseProfile);
      final warehouse = CourierWarehouse.fromJson(responseWarehouse);
      final vehicle = CourierVehicle.fromJson(responseVehicle);

      courier.warehouse = warehouse;
      courier.vehicle = vehicle;

      item = courier;

      _setStatus(LoadingStatuses.finished, courierLoadType);
    }

    notifyListeners();
    return _getStatus(courierLoadType) == LoadingStatuses.finished;
  }

  Future<bool> setInWarehouse() async {
    inWarehouseLoadingStatus = LoadingStatuses.loading;
    final response = (await _fetchSetInWarehouse());
    final responseMessages = response['message'] as List<dynamic>;

    if (response['code'] == 401) {
      inWarehouseLoadingStatus = LoadingStatuses.noAuthorize;
    } else if (responseMessages == null || response['code'] as int >= 500) {
      inWarehouseLoadingStatus = LoadingStatuses.noConnection;
    } else if (responseMessages.isNotEmpty) {
      inWarehouseLoadingStatus = LoadingStatuses.failed;
    } else {
      final responseData = response['data'] as Map<String, dynamic>;
      final responseProfile = responseData['profile'] as Map<String, dynamic>;

      final courier = Courier.fromJson(responseProfile);

      item.merge(courier);

      inWarehouseLoadingStatus = LoadingStatuses.finished;
    }

    notifyListeners();

    return inWarehouseLoadingStatus == LoadingStatuses.finished;
  }
}
