import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';
import 'package:optima_delivery_mobile/common/widgets/Button.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

class DeliveryFinishModalContent extends StatelessWidget {
  final int restCount;

  DeliveryFinishModalContent(this.restCount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: SizedBox(
            width: StyleSizes.modalWeight,
            height: StyleSizes.modalHeight,
            child: SvgPicture.asset(
              'assets/images/box.svg',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: StylePaddings.xxsValue),
          child: Text(
            S.of(context).greatJob,
            style: StyleFont.styleH6,
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: StyleSizes.modalContentMaxWeight,
          ),
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            S.of(context).restDeliveries(restCount),
            textAlign: TextAlign.center,
            style: StyleFont.styleP2,
            maxLines: 2,
          ),
        ),
        Button(
          text: S.of(context).goToDeliveriesList.toUpperCase(),
          onPressed: () {
            Navigator.popUntil(context, (route) {
              final checkDeliveryList = ModalRoute.withName('/delivery-list');
              final checkDeliveryMap = ModalRoute.withName('/map');
              return checkDeliveryList(route) || checkDeliveryMap(route);
            });
          },
          width: double.infinity,
        ),
      ],
    );
  }
}
