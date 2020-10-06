import 'dart:io';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/helpers/date.dart';
import 'package:optima_delivery_mobile/common/helpers/snack.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/widgets/Button.dart';
import 'package:optima_delivery_mobile/common/widgets/InfoItem.dart';
import 'package:optima_delivery_mobile/common/widgets/Modal.dart';
import 'package:optima_delivery_mobile/delivery/types/DeliveryTypes.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

const emptyDeliveryInfoData = {
  'saleNumber': '',
  'buyerName': '',
  'buyerPhone': '',
  'address': '',
  'deliveryTimePlanned': '',
  'deliveryTimeFrom': '',
  'deliveryTimeTo': '',
  'orderCost': '',
  'isOrderPaid': false,
  'deliveryCost': ''
};

const yandexNavigatorPackageName = 'ru.yandex.yandexnavi';
const yandexNavigatorMarketUrl =
    'market://details?id=$yandexNavigatorPackageName';

String getYandexNavigatorUrl(double lat, double lon) {
  return Uri.encodeFull(
      'yandexnavi://build_route_on_map?lat_to=$lat&lon_to=$lon');
}

class DeliveryInfo extends StatelessWidget {
  final DeliveryItem delivery;
  final DeliveryClient client;

  DeliveryInfo({@required this.delivery, @required this.client});

  Map<String, dynamic> _getInfo() {
    if (delivery == null) {
      return emptyDeliveryInfoData;
    }
    var buyerPhone;
    var buyerName;

    if (delivery.buyer != null) {
      buyerPhone =
          delivery.buyer.phone != null ? delivery.buyer.phone.toString() : null;
      buyerName = delivery.buyer.name;
    }

    return {
      'saleNumber':
          delivery.saleNumber != null ? delivery.saleNumber.toString() : null,
      'buyerName': buyerName,
      'buyerPhone': buyerPhone,
      'address': delivery.address != null ? delivery.address.title : null,
      'coordinates':
          delivery.address != null ? delivery.address.coordinates : null,
      'deliveryTimePlanned': delivery.deliveryTimePlanned,
      'deliveryTimeFrom': delivery.deliveryTimeFrom,
      'deliveryTimeTo': delivery.deliveryTimeTo,
      'orderCost':
          delivery.orderCost != null ? delivery.orderCost.toString() : null,
      'isOrderPaid': delivery.isOrderPaid,
      'deliveryCost': delivery.deliveryCost != null
          ? delivery.deliveryCost.toString()
          : null,
      'isDeliveryPaid': delivery.isDeliveryPaid,
      'paymentMethod': delivery.paymentMethod,
      'comment': delivery.comment,
      'clientName': client != null ? client.name : null,
    };
  }

  String _getTime(String deliveryTimePlanned, String deliveryTimeFrom,
      String deliveryTimeTo) {
    var result = '';

    if (deliveryTimePlanned != null) {
      final formattedTimePlanned = dateFormat(deliveryTimePlanned);
      result = formattedTimePlanned;
    }

    if (deliveryTimeFrom != null && deliveryTimeTo != null) {
      final formattedTimeFrom = dateFormat(deliveryTimeFrom);
      final formattedTimeTo = dateFormat(deliveryTimeTo);

      if (result != '') {
        result += ' ($formattedTimeFrom - $formattedTimeTo)';
      } else {
        result = '$formattedTimeFrom - $formattedTimeTo';
      }
    }

    return result;
  }

  Map _getAddressProps(Map info, BuildContext context) {
    if (info['coordinates'] != null && Platform.isAndroid) {
      return {
        'iconColor': StyleColors.primary6,
        'onTap': () async {
          final intent = AndroidIntent(
            action: 'action_view',
            data: getYandexNavigatorUrl(
              info['coordinates'].lat as double,
              info['coordinates'].lon as double,
            ),
            package: yandexNavigatorPackageName,
          );

          if (await intent.canResolveActivity() == true) {
            await intent.launch();
          } else {
            final isSuccess = await showSpecialDialog(
              mainAxisAlignment: MainAxisAlignment.start,
              context: context,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: StylePaddings.sValue,
                    bottom: StylePaddings.lValue,
                    left: StylePaddings.mValue,
                    right: StylePaddings.mValue,
                  ),
                  child: Text(
                    S.of(context).notFoundNavigator,
                    style: StyleFont.styleSubtitle1,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        right: StylePaddings.xsValue,
                      ),
                      child: Button(
                        hasShadow: false,
                        color: Colors.transparent,
                        textColor: StyleColors.primary7,
                        text: S.of(context).cancel.toUpperCase(),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                      ),
                    ),
                    Button(
                      hasShadow: false,
                      color: Colors.transparent,
                      textColor: StyleColors.primary7,
                      text: S.of(context).goTo.toUpperCase(),
                      onPressed: () async {
                        if (await canLaunch(yandexNavigatorMarketUrl)) {
                          await launch(yandexNavigatorMarketUrl);
                          Navigator.pop(context, true);
                        } else {
                          Navigator.pop(context, false);
                        }
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ],
            );

            if (isSuccess == false) {
              final snackBar = getErrorSnackBar(context,
                  messageKey: 'notFoundPlayMarket', durationSecond: 3);
              Scaffold.of(context).showSnackBar(snackBar);
            }
          }
        },
      };
    }
    return {
      'iconColor': null,
      'onTap': null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final info = _getInfo();
    final addressProps = _getAddressProps(info, context);
    return Column(
      children: <Widget>[
        InfoItem(
          svgPath: 'assets/icons/note_list.svg',
          label: S.of(context).salesNumber,
          value: info['saleNumber'] as String,
        ),
        InfoItem(
          svgPath: 'assets/icons/person.svg',
          label: S.of(context).client,
          value: info['buyerName'] as String,
        ),
        InfoItem(
          svgPath: 'assets/icons/phone.svg',
          label: S.of(context).phoneNumber,
          value: info['buyerPhone'] as String,
        ),
        InfoItem(
          svgPath: 'assets/icons/address.svg',
          label: S.of(context).address,
          value: info['address'] as String,
          iconColor: addressProps['iconColor'] as Color,
          onTap: addressProps['onTap'] as void Function(),
        ),
        InfoItem(
          svgPath: 'assets/icons/clock.svg',
          label: S.of(context).time,
          value: _getTime(
              info['deliveryTimePlanned'] as String,
              info['deliveryTimeFrom'] as String,
              info['deliveryTimeTo'] as String),
        ),
        InfoItem(
          svgPath: 'assets/icons/building.svg',
          label: S.of(context).customer,
          value: info['clientName'] as String,
        ),
        InfoItem(
          svgPath: 'assets/icons/order_cost.svg',
          label: S.of(context).orderPrice,
          value: info['orderCost'] != null
              ? '${info['orderCost']} ₽ ${info['isOrderPaid'] == true ? '(${S.of(context).isPaid})' : ''}'
              : '',
        ),
        InfoItem(
          svgPath: 'assets/icons/delivery_cost.svg',
          label: S.of(context).costOfDelivery,
          value: info['deliveryCost'] != null
              ? '${info['deliveryCost']} ₽ ${info['isDeliveryPaid'] == true ? '(${S.of(context).isPaid})' : ''}'
              : '',
        ),
        InfoItem(
          svgPath: 'assets/icons/card.svg',
          label: S.of(context).paymentMethod,
          value: info['paymentMethod'] as String,
        ),
        InfoItem(
          svgPath: 'assets/icons/comment.svg',
          label: S.of(context).comment,
          value: info['comment'] as String,
        ),
      ],
    );
  }
}
