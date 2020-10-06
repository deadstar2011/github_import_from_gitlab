import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/gradients.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';
import 'package:optima_delivery_mobile/common/widgets/Avatar.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

class CourierProfileCard extends StatelessWidget {
  final String firstName;
  final String middleName;
  final String lastName;

  CourierProfileCard({
    @required this.firstName,
    @required this.middleName,
    @required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: StylePaddings.l,
      height: StyleSizes.courierProfileCardHeight,
      decoration: BoxDecoration(
        gradient: StyleGradients.purple,
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Avatar(
            firstName: firstName,
            middleName: middleName,
          ),
          Container(
            padding: EdgeInsets.only(
              left: StylePaddings.lValue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  S.of(context).courier,
                  style: StyleFont.styleCaption.merge(
                    TextStyle(
                      color: StyleColors.primary4,
                    ),
                  ),
                ),
                Text(
                  middleName ?? '',
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                  style: StyleFont.styleSubtitle1.merge(
                    TextStyle(
                      color: StyleColors.white,
                    ),
                  ),
                ),
                Text(
                  '${firstName ?? ''} ${lastName ?? ''}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: StyleFont.styleSubtitle1.merge(
                    TextStyle(
                      color: StyleColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
