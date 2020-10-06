import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optima_delivery_mobile/common/types/AddressTypes.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';
import 'package:optima_delivery_mobile/common/widgets/Button.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

void stub() {}

class DeliveryCourierCardInfo {
  void Function() action;
  String actionTitle;
  String address;
  String description;
  String svgPath;

  DeliveryCourierCardInfo({
    this.action,
    this.actionTitle,
    this.address,
    this.description,
    this.svgPath,
    this.title,
  });

  String title;
}

class DeliveryCourierCard extends StatelessWidget {
  final String status;
  final Address address;
  final void Function() onGetLocationPermission;
  final void Function() onArrivedAtWarehouse;
  final void Function() onEnableGeolocation;

  DeliveryCourierCard({
    @required this.status,
    this.address,
    this.onGetLocationPermission = stub,
    this.onArrivedAtWarehouse = stub,
    this.onEnableGeolocation = stub,
  });

  DeliveryCourierCardInfo _getContent(BuildContext context) {
    switch (status) {
      case 'notOnShift':
        return DeliveryCourierCardInfo(
          address: address != null ? address.title : null,
          title: S.of(context).notOnShift,
          description: S.of(context).notOnShiftDescription,
          actionTitle: S.of(context).arrivedWarehouse,
          action: onArrivedAtWarehouse,
          svgPath: 'assets/icons/circle_query.svg',
        );
      case 'calculation':
        return DeliveryCourierCardInfo(
          title: S.of(context).routeBeingFormed,
          description: S.of(context).routeBeingFormedDescription,
          svgPath: 'assets/icons/circle_time.svg',
        );
      case 'emptyWarehouse':
        return DeliveryCourierCardInfo(
          title: S.of(context).routeNotFormed,
          description: S.of(context).routeNotFormedDescription,
          svgPath: 'assets/icons/circle_error.svg',
        );
      case 'finished':
        return DeliveryCourierCardInfo(
          address: address != null ? address.title : null,
          title: S.of(context).routeCompleted,
          description: S.of(context).routeCompletedDescription,
          actionTitle: S.of(context).arrivedWarehouse,
          action: onArrivedAtWarehouse,
          svgPath: 'assets/icons/circle_success.svg',
        );
      case 'noGeolocation':
        return DeliveryCourierCardInfo(
          title: S.of(context).noGeolocation,
          description: S.of(context).noGeolocationDescription,
          actionTitle: S.of(context).allowTracking,
          action: onGetLocationPermission,
          svgPath: 'assets/icons/circle_error.svg',
        );
      case 'disabledGeolocation':
        return DeliveryCourierCardInfo(
          title: S.of(context).geolocationDisabled,
          description: S.of(context).geolocationDisabledDescription,
          actionTitle: S.of(context).done,
          action: onEnableGeolocation,
          svgPath: 'assets/icons/circle_error.svg',
        );
      default:
        return DeliveryCourierCardInfo(
          title: S.of(context).undefinedStatus,
          description: '',
          svgPath: 'assets/icons/circle_time.svg',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _getContent(context);

    return Container(
      decoration: BoxDecoration(
        color: StyleColors.white,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      padding: StylePaddings.l,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: StyleSizes.bigIcon,
            width: StyleSizes.bigIcon,
            child: SvgPicture.asset(
              content.svgPath,
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: StyleSizes.deliveryCourierCardMaxWidth,
            ),
            padding: const EdgeInsets.only(
              top: StylePaddings.xlValue,
              bottom: StylePaddings.mValue,
            ),
            child: Text(
              content.title,
              style: StyleFont.styleH5,
              maxLines: 2,
            ),
          ),
          Text(
            content.description,
            style: StyleFont.styleP2.merge(
              TextStyle(
                color: StyleColors.graphite7,
              ),
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          if (content.address != null)
            Padding(
              padding: const EdgeInsets.only(
                top: StylePaddings.mValue,
              ),
              child: Text(
                content.address,
                style: StyleFont.styleSubtitle1,
              ),
            ),
          if (content.actionTitle != null)
            Padding(
              padding: const EdgeInsets.only(
                top: StylePaddings.xlValue,
              ),
              child: Button(
                text: content.actionTitle.toUpperCase(),
                onPressed: content.action,
                width: double.infinity,
              ),
            ),
        ],
      ),
    );
  }
}
