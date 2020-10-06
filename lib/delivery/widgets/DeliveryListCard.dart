import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/helpers/date.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';
import 'package:optima_delivery_mobile/delivery/types/DeliveryTypes.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryStatusMark.dart';

class DeliveryListCard extends StatelessWidget {
  final DeliveryItem delivery;
  final void Function() onTap;

  DeliveryListCard({@required this.delivery, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: StyleSizes.deliveryListCardHeight,
          padding: EdgeInsets.symmetric(
            horizontal: StylePaddings.xsValue,
            vertical: StylePaddings.mValue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  DeliveryStatusMark(delivery.status),
                  Text(
                    delivery.deliveryTimePlanned != null
                        ? dateFormat(delivery.deliveryTimePlanned)
                        : '',
                    style: StyleFont.styleOverLine.merge(
                      TextStyle(
                        color: StyleColors.graphite7,
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 2.0,
                  bottom: StylePaddings.xxsValue,
                ),
                child: Text(
                  delivery.address != null && delivery.address.title != null
                      ? delivery.address.title
                      : '',
                  style: StyleFont.styleP2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                delivery.number != null ? '#${delivery.number}' : '',
                style: StyleFont.styleOverLine.merge(
                  TextStyle(
                    color: StyleColors.graphite7,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
