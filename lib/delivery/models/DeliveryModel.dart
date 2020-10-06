import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/helpers/api.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/common/helpers/model.dart';
import 'package:optima_delivery_mobile/delivery/types/DeliveryTypes.dart';

class DeliveryModel extends ChangeNotifier {
  bool isMore = true;
  String deliveriesStatus;
  List<int> list = [];
  Map<int, DeliveryItem> data = {};
  Map<int, DeliveryClient> clientData = {};
  LoadingStatuses listLoadingStatus = LoadingStatuses.untouched;
  LoadingStatuses itemLoadingStatus = LoadingStatuses.untouched;
  LoadingStatuses itemChangeStatus = LoadingStatuses.untouched;

  Future<Map<String, dynamic>> _fetchList({int limit, int offset}) {
    return api.get('/api/v1/couriers/deliveries', params: {
      'limit': limit,
      'offset': offset,
      'links': ['clients']
    });
  }

  Future<Map<String, dynamic>> _fetchItem(int id) {
    return api.get('/api/v1/deliveries/${id}', params: {
      'links': ['client']
    });
  }

  Future<Map<String, dynamic>> _fetchGo(int id) {
    return api.put('/api/v1/deliveries/${id}/go');
  }

  Future<Map<String, dynamic>> _fetchRefuse(int id, String reasonId) {
    return api.put('/api/v1/deliveries/${id}/refuse',
        body: {'refuseReasonId': reasonId});
  }

  Future<Map<String, dynamic>> _fetchFinish(int id) {
    return api.put('/api/v1/deliveries/${id}/finish');
  }

  Future<Map<String, dynamic>> _fetchCall(int id, int callResult) {
    return api.put('/api/v1/deliveries/${id}/call',
        body: {'callResult': callResult.toString()});
  }

  void clear() {
    deliveriesStatus = null;
    isMore = true;
    list = [];
    data = {};
    clientData = {};
    listLoadingStatus = LoadingStatuses.untouched;
    itemLoadingStatus = LoadingStatuses.untouched;
    itemChangeStatus = LoadingStatuses.untouched;
  }

  Future<void> loadList({int limit, int offset}) async {
    listLoadingStatus = LoadingStatuses.loading;

    final response = await _fetchList(limit: limit, offset: offset);
    final responseMessages = response['message'] as List<dynamic>;

    if (response['code'] == 401) {
      listLoadingStatus = LoadingStatuses.noAuthorize;
    } else if (responseMessages == null || response['code'] as int >= 500) {
      listLoadingStatus = LoadingStatuses.noConnection;
    } else if (responseMessages.isNotEmpty) {
      listLoadingStatus = LoadingStatuses.failed;
    } else {
      final responseData = response['data'] as Map<String, dynamic>;
      final responseDeliveryList =
          responseData['deliveriesList'] as List<dynamic>;

      list = responseDeliveryList.map(getItemId).toList();
      isMore = responseData['more'] as bool;
      deliveriesStatus = responseData['status'] as String;
      responseDeliveryList.forEach(
        (item) {
          final delivery = DeliveryItem.fromJson(item);
          if (data[delivery.id] != null) {
            data[delivery.id].merge(delivery);
          } else {
            data[delivery.id] = delivery;
          }
        },
      );

      listLoadingStatus = LoadingStatuses.finished;
    }

    notifyListeners();

    return listLoadingStatus == LoadingStatuses.finished;
  }

  // TODO: Сейчас не используеться, но и не мешает. Если точно список будет без подзагрузки, то можно выпилить
  void appendListList({int limit = 0}) async {
    final response = (await _fetchList(limit: limit, offset: list.length));
    final responseMessages = response['message'] as List<dynamic>;

    if (response['code'] == 401) {
      listLoadingStatus = LoadingStatuses.noAuthorize;
    } else if (responseMessages == null || response['code'] as int >= 500) {
      listLoadingStatus = LoadingStatuses.noConnection;
    } else if (responseMessages.isNotEmpty) {
      listLoadingStatus = LoadingStatuses.failed;
    } else {
      final responseData = response['data'] as Map<String, dynamic>;
      final responseDeliveryList =
          responseData['deliveriesList'] as List<dynamic>;

      list.addAll(responseDeliveryList.map(getItemId));
      isMore = responseData['more'] as bool;
      deliveriesStatus = responseData['status'] as String;
      responseDeliveryList.forEach(
        (item) {
          final delivery = DeliveryItem.fromJson(item);
          if (data[delivery.id] != null) {
            data[delivery.id].merge(delivery);
          } else {
            data[delivery.id] = delivery;
          }
        },
      );
    }
    notifyListeners();
  }

  void loadItem(int id) async {
    itemLoadingStatus = LoadingStatuses.loading;

    final response = (await _fetchItem(id));
    final responseMessages = response['message'] as List<dynamic>;

    if (response['code'] == 401) {
      itemLoadingStatus = LoadingStatuses.noAuthorize;
    } else if (responseMessages == null || response['code'] as int >= 500) {
      itemLoadingStatus = LoadingStatuses.noConnection;
    } else if (responseMessages.isNotEmpty) {
      itemLoadingStatus = LoadingStatuses.failed;
    } else {
      final responseData = response['data'] as Map<String, dynamic>;
      final responseDelivery = responseData['delivery'] as Map<String, dynamic>;
      final responseClient = responseData['client'] as Map<String, dynamic>;

      final delivery = DeliveryItem.fromJson(responseDelivery);
      final client = DeliveryClient.fromJson(responseClient);

      if (data[delivery.id] != null) {
        data[delivery.id].merge(delivery);
      } else {
        data[delivery.id] = delivery;
      }

      if (clientData[client.id] != null) {
        clientData[client.id].merge(client);
      } else {
        clientData[client.id] = client;
      }

      itemLoadingStatus = LoadingStatuses.finished;
    }
    notifyListeners();
  }

  Future<bool> setGoItem(int id) async {
    itemChangeStatus = LoadingStatuses.loading;

    final response = (await _fetchGo(id));
    final responseMessages = response['message'] as List<dynamic>;

    if (response['code'] == 401) {
      itemChangeStatus = LoadingStatuses.noAuthorize;
    } else if (responseMessages == null || response['code'] as int >= 500) {
      itemChangeStatus = LoadingStatuses.noConnection;
    } else if (responseMessages.isNotEmpty) {
      itemChangeStatus = LoadingStatuses.failed;
    } else {
      final responseData = response['data'] as Map<String, dynamic>;
      final responseDelivery = responseData['delivery'] as Map<String, dynamic>;
      final delivery = DeliveryItem.fromJson(responseDelivery);

      if (data[delivery.id] != null) {
        data[delivery.id].merge(delivery);
      } else {
        data[delivery.id] = delivery;
      }

      itemChangeStatus = LoadingStatuses.finished;
    }

    notifyListeners();
    return itemChangeStatus == LoadingStatuses.finished;
  }

  Future<bool> setRefuseItem(int id, String reasonId) async {
    itemChangeStatus = LoadingStatuses.loading;

    final response = (await _fetchRefuse(id, reasonId));
    final responseMessages = response['message'] as List<dynamic>;

    if (response['code'] == 401) {
      itemChangeStatus = LoadingStatuses.noAuthorize;
    } else if (responseMessages == null || response['code'] as int >= 500) {
      itemChangeStatus = LoadingStatuses.noConnection;
    } else if (responseMessages.isNotEmpty) {
      itemChangeStatus = LoadingStatuses.failed;
    } else {
      final responseData = response['data'] as Map<String, dynamic>;
      final responseDelivery = responseData['delivery'] as Map<String, dynamic>;
      final delivery = DeliveryItem.fromJson(responseDelivery);

      if (data[delivery.id] != null) {
        data[delivery.id].merge(delivery);
      } else {
        data[delivery.id] = delivery;
      }

      itemChangeStatus = LoadingStatuses.finished;
    }

    notifyListeners();
    return itemChangeStatus == LoadingStatuses.finished;
  }

  Future<bool> setFinishItem(int id) async {
    itemChangeStatus = LoadingStatuses.loading;

    final response = (await _fetchFinish(id));
    final responseMessages = response['message'] as List<dynamic>;

    if (response['code'] == 401) {
      itemChangeStatus = LoadingStatuses.noAuthorize;
    } else if (responseMessages == null || response['code'] as int >= 500) {
      itemChangeStatus = LoadingStatuses.noConnection;
    } else if (responseMessages.isNotEmpty) {
      itemChangeStatus = LoadingStatuses.failed;
    } else {
      final responseData = response['data'] as Map<String, dynamic>;
      final responseDelivery = responseData['delivery'] as Map<String, dynamic>;
      final delivery = DeliveryItem.fromJson(responseDelivery);

      if (data[delivery.id] != null) {
        data[delivery.id].merge(delivery);
      } else {
        data[delivery.id] = delivery;
      }

      itemChangeStatus = LoadingStatuses.finished;
    }

    notifyListeners();
    return itemChangeStatus == LoadingStatuses.finished;
  }

  Future<bool> setCallItem(int id, int callResult) async {
    itemChangeStatus = LoadingStatuses.loading;

    final response = (await _fetchCall(id, callResult));
    final responseMessages = response['message'] as List<dynamic>;

    if (response['code'] == 401) {
      itemChangeStatus = LoadingStatuses.noAuthorize;
    } else if (responseMessages == null || response['code'] as int >= 500) {
      itemChangeStatus = LoadingStatuses.noConnection;
    } else if (responseMessages.isNotEmpty) {
      itemChangeStatus = LoadingStatuses.failed;
    } else {
      final responseData = response['data'] as Map<String, dynamic>;
      final responseDelivery = responseData['delivery'] as Map<String, dynamic>;
      final delivery = DeliveryItem.fromJson(responseDelivery);

      if (data[delivery.id] != null) {
        data[delivery.id].merge(delivery);
      } else {
        data[delivery.id] = delivery;
      }

      itemChangeStatus = LoadingStatuses.finished;
    }

    notifyListeners();
    return itemChangeStatus == LoadingStatuses.finished;
  }

  List<DeliveryItem> get listItems =>
      list.map(getItem<DeliveryItem>(data)).toList();

  int get restCount {
    var count = 0;
    list.forEach((id) {
      final item = data[id];
      if (!_isItemClosed(item)) {
        count++;
      }
    });

    return count;
  }

  bool _isItemClosed(DeliveryItem item) {
    if (item != null &&
        (item.status == 'refused' ||
            item.status == 'finished' ||
            item.status == 'problems' ||
            item.status == 'doNotDial')) {
      return true;
    }

    return false;
  }

  DeliveryItem getDeliveryItem(int id) {
    return getItem<DeliveryItem>(data)(id);
  }

  DeliveryClient getClientItem(int id) {
    return getItem<DeliveryClient>(clientData)(id);
  }

  DeliveryItem get currentItem {
    if (listItems.isEmpty) {
      return null;
    }

    final currentItem = listItems.firstWhere(
      (item) => item.status == 'current',
      orElse: () => listItems.firstWhere(
          (item) =>
              item.status == 'needCall' ||
              item.status == 'inProgress' ||
              item.status == 'assigned',
          orElse: () => null),
    );

    return currentItem;
  }
}
