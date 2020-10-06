import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/gradients.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';
import 'package:optima_delivery_mobile/common/widgets/ButtonWithIcon.dart';
import 'package:optima_delivery_mobile/delivery/types/DeliveryTypes.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryCardInfo {
  String title;
  String description;
  List<String> actionList;

  DeliveryCardInfo({this.title, this.description, this.actionList});
}

class DeliveryCardAction {
  String svgPath;
  String label;
  void Function() onPressed;

  DeliveryCardAction({this.svgPath, this.label, this.onPressed});
}

class DeliveryCard extends StatelessWidget {
  final DeliveryItem delivery;
  final void Function() onClientReady;
  final void Function() onNotDial;
  final void Function() onStartMoving;
  final void Function() onDelivered;
  final void Function() onHaveProblems;

  DeliveryCard({
    @required this.delivery,
    @required this.onClientReady,
    @required this.onNotDial,
    @required this.onStartMoving,
    @required this.onDelivered,
    @required this.onHaveProblems,
  });

  DeliveryCardInfo _getContent(BuildContext context) {
    switch (delivery.status) {
      case 'assigned':
        return DeliveryCardInfo(
          title: S.of(context).contactClient,
          description: S.of(context).contactClientDescription,
          actionList: ['call', 'inProgress', 'doNotDial'],
        );
      case 'needCall':
        return DeliveryCardInfo(
          title: S.of(context).contactClient,
          description: S.of(context).contactClientDescription,
          actionList: ['call', 'inProgress', 'doNotDial'],
        );
      case 'inProgress':
        return DeliveryCardInfo(
          title: S.of(context).clientNotified,
          description: S.of(context).clientNotifiedDescription,
          actionList: ['call', 'current'],
        );
      case 'current':
        return DeliveryCardInfo(
          title: S.of(context).EnterOrderStatus,
          description: S.of(context).EnterOrderDescription,
          actionList: ['call', 'finished', 'problems'],
        );
      default:
        return DeliveryCardInfo(title: '', description: '', actionList: []);
    }
  }

  DeliveryCardAction _getAction(String actionType, BuildContext context) {
    switch (actionType) {
      case 'call':
        return DeliveryCardAction(
          label: S.of(context).actionCall,
          svgPath: 'assets/icons/cellphone.svg',
          onPressed: () async {
            if (delivery != null &&
                delivery.buyer != null &&
                await canLaunch('tel:+${delivery.buyer.phone}')) {
              await launch('tel:+${delivery.buyer.phone}');
            }
          },
        );
      case 'inProgress':
        return DeliveryCardAction(
          label: S.of(context).actionClientReady,
          svgPath: 'assets/icons/success.svg',
          onPressed: onClientReady,
        );
      case 'doNotDial':
        return DeliveryCardAction(
          label: S.of(context).actionNotDial,
          svgPath: 'assets/icons/cancel_cellphone.svg',
          onPressed: onNotDial,
        );
      case 'current':
        return DeliveryCardAction(
          label: S.of(context).actionStartMoving,
          svgPath: 'assets/icons/car.svg',
          onPressed: onStartMoving,
        );
      case 'finished':
        return DeliveryCardAction(
          label: S.of(context).actionDelivered,
          svgPath: 'assets/icons/success.svg',
          onPressed: onDelivered,
        );
      case 'problems':
        return DeliveryCardAction(
          label: S.of(context).actionHaveProblems,
          svgPath: 'assets/icons/attention.svg',
          onPressed: onHaveProblems,
        );
      default:
        return DeliveryCardAction(
          label: '',
          svgPath: '',
          onPressed: () {},
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _getContent(context);

    return Container(
      padding: StylePaddings.m,
      height: StyleSizes.deliveryCardHeight,
      decoration: BoxDecoration(
        gradient: StyleGradients.purple,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: StylePaddings.xsValue,
            ),
            child: Text(
              content.title,
              style: StyleFont.styleH6.merge(
                TextStyle(
                  color: StyleColors.white,
                ),
              ),
            ),
          ),
          Text(
            content.description,
            style: StyleFont.styleP2.merge(
              TextStyle(
                color: StyleColors.white,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(
                top: StylePaddings.mValue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: content.actionList.map((String item) {
                  final action = _getAction(item, context);

                  return ButtonWithIcon(
                    label: action.label,
                    svgPath: action.svgPath,
                    onPressed: action.onPressed,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
