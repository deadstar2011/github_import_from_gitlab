import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

class DeliveryStatusInfo {
  String label;
  Color color;

  DeliveryStatusInfo({
    this.label,
    this.color,
  });
}

class DeliveryStatusMark extends StatelessWidget {
  final String status;

  DeliveryStatusMark(this.status);

  DeliveryStatusInfo _getMarkInfo(BuildContext context) {
    switch (status) {
      case 'needCall':
        return DeliveryStatusInfo(
          color: StyleColors.red7,
          label: S.of(context).needCallMark,
        );
      case 'current':
        return DeliveryStatusInfo(
          color: StyleColors.greenMark,
          label: S.of(context).performedMark,
        );
      case 'inProgress':
        return DeliveryStatusInfo(
            color: StyleColors.primary6,
            label: S.of(context).clientNotifiedMark);
      case 'doNotDial':
        return DeliveryStatusInfo(
          color: StyleColors.orangeMark,
          label: S.of(context).notDialMark,
        );
      case 'refused':
        return DeliveryStatusInfo(
          color: StyleColors.graphite8,
          label: S.of(context).refusedMark,
        );
      case 'problems':
        return DeliveryStatusInfo(
          color: StyleColors.graphite8,
          label: S.of(context).problemsMark,
        );
      case 'finished':
        return DeliveryStatusInfo(
          color: StyleColors.graphite8,
          label: S.of(context).finishedMark,
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = _getMarkInfo(context);

    if (info == null) {
      return Container();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: StylePaddings.xxsValue,
            right: StylePaddings.xxsValue,
          ),
          child: Container(
            width: StyleSizes.mark,
            height: StyleSizes.mark,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
                color: info.color,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
            ),
          ),
        ),
        Text(
          info.label,
          style: StyleFont.styleCaption.merge(
            TextStyle(
              color: StyleColors.graphite6,
            ),
          ),
        ),
      ],
    );
  }
}
