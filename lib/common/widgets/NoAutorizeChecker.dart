import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/courier/models/CourierModel.dart';
import 'package:optima_delivery_mobile/delivery/models/DeliveryModel.dart';
import 'package:provider/provider.dart';

class NoAuthorizeChecker extends StatefulWidget {
  final LoadingStatuses loadingStatus;
  final Widget child;

  NoAuthorizeChecker({
    @required this.loadingStatus,
    @required this.child,
  });

  @override
  NoAuthorizeCheckerState createState() => NoAuthorizeCheckerState();
}

class NoAuthorizeCheckerState extends State<NoAuthorizeChecker> {
  CourierModel courierModel;
  DeliveryModel deliveryModel;
  bool isRedirected = false;

  @override
  void initState() {
    super.initState();

    courierModel = Provider.of<CourierModel>(context, listen: false);
    deliveryModel = Provider.of<DeliveryModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loadingStatus == LoadingStatuses.noAuthorize) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!isRedirected) {
          deliveryModel.clear();
          courierModel.logout();
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          isRedirected = true;
        }
      });

      return Container();
    }

    return widget.child;
  }
}
