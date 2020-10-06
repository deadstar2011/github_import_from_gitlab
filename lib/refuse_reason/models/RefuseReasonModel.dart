import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/helpers/api.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/common/helpers/model.dart';
import 'package:optima_delivery_mobile/common/widgets/RadioGroup.dart';
import 'package:optima_delivery_mobile/refuse_reason/types/RefuseReasonTypes.dart';

class RefuseReasonModel extends ChangeNotifier {
  LoadingStatuses loadingStatus = LoadingStatuses.untouched;
  Map<int, RefuseReason> data = {};
  List<int> list = [];

  Future<Map<String, dynamic>> fetch(int deliveryId) {
    return api.get('/api/v1/deliveries/${deliveryId}/refuse-reasons');
  }

  void loadList(int deliveryId) async {
    loadingStatus = LoadingStatuses.loading;
    final response = (await fetch(deliveryId));
    final responseMessages = response['message'] as List<dynamic>;

    if (responseMessages == null || response['code'] as int >= 500) {
      loadingStatus = LoadingStatuses.noConnection;
    } else if (responseMessages.isNotEmpty) {
      loadingStatus = LoadingStatuses.failed;
    } else {
      final responseData = response['data'] as Map<String, dynamic>;
      final responseList = responseData['list'] as List<dynamic>;
      list = responseList.map(getItemId).toList();

      responseList.forEach(
        (item) {
          final refuseReason = RefuseReason.fromJson(item);
          if (data[refuseReason.id] != null) {
            data[refuseReason.id].merge(refuseReason);
          } else {
            data[refuseReason.id] = refuseReason;
          }
        },
      );

      loadingStatus = LoadingStatuses.finished;
    }

    notifyListeners();
  }

  List<RadioOption> get optionItems {
    return list.map((id) {
      final item = data[id];
      return RadioOption(title: item.title, value: item.id.toString());
    }).toList();
  }
}
