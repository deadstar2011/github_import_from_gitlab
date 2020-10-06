import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/widgets/InfoItem.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:optima_delivery_mobile/courier/types/CourierTypes.dart';

class CourierProfileInfo extends StatelessWidget {
  final Courier courier;

  CourierProfileInfo({@required this.courier});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InfoItem(
          svgPath: 'assets/icons/address.svg',
          label: S.of(context).warehouseAddress,
          value: courier != null && courier.warehouse != null
              ? courier.warehouse.address.title
              : '',
        ),
        InfoItem(
          svgPath: 'assets/icons/car_grey.svg',
          label: S.of(context).vehicle,
          value: courier != null && courier.vehicle != null
              ? '${courier.vehicle.name} ${courier.vehicle.number}'
              : '',
        ),
      ],
    );
  }
}
