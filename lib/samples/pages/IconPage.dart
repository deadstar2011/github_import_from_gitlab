import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';
import 'package:optima_delivery_mobile/common/widgets/Box.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

class IconPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      isAppNavigatorVisible: false,
      title: S.of(context).samplesIcon,
      body: Box(children: <Widget>[
        Column(
          children: <Widget>[
            Row(children: <Widget>[
              SizedBox(
                height: StyleSizes.smallIcon,
                child: SvgPicture.asset(
                  'assets/icons/attention.svg',
                ),
              ),
              SizedBox(
                height: StyleSizes.smallIcon,
                child: SvgPicture.asset(
                  'assets/icons/address.svg',
                  color: StyleColors.primary6,
                ),
              ),
              SizedBox(
                height: StyleSizes.smallIcon,
                child: SvgPicture.asset(
                  'assets/icons/address_filled.svg',
                  color: StyleColors.primary6,
                ),
              ),
              SizedBox(
                height: StyleSizes.smallIcon,
                child: SvgPicture.asset(
                  'assets/icons/building.svg',
                  color: StyleColors.primary6,
                ),
              ),
              SizedBox(
                height: StyleSizes.smallIcon,
                child: SvgPicture.asset(
                  'assets/icons/cancel_cellphone.svg',
                  color: StyleColors.primary6,
                ),
              ),
              SizedBox(
                height: StyleSizes.smallIcon,
                child: SvgPicture.asset(
                  'assets/icons/car.svg',
                  color: StyleColors.primary6,
                ),
              ),
              SizedBox(
                height: StyleSizes.smallIcon,
                child: SvgPicture.asset(
                  'assets/icons/car_grey.svg',
                  color: StyleColors.primary6,
                ),
              ),
              SizedBox(
                height: 36,
                child: SvgPicture.asset(
                  'assets/icons/car_marker.svg',
                ),
              ),
              SizedBox(
                height: 36,
                child: SvgPicture.asset(
                  'assets/icons/car_marker_active.svg',
                ),
              ),
            ]),
            Row(
              children: <Widget>[
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/card.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/cellphone.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: 36,
                  child: SvgPicture.asset(
                    'assets/icons/circle_error.svg',
                  ),
                ),
                SizedBox(
                  height: 36,
                  child: SvgPicture.asset(
                    'assets/icons/circle_query.svg',
                  ),
                ),
                SizedBox(
                  height: 36,
                  child: SvgPicture.asset(
                    'assets/icons/circle_success.svg',
                  ),
                ),
                SizedBox(
                  height: 36,
                  child: SvgPicture.asset(
                    'assets/icons/circle_time.svg',
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/clock.svg',
                    color: StyleColors.primary6,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/comment.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/delivery_cost.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/dispatcher.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/go_out.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/logout.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/map.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/note_list.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/order_cost.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/person.svg',
                    color: StyleColors.primary6,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/phone.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/routes.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/settings.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/success.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/backspace.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/close.svg',
                    color: StyleColors.primary6,
                  ),
                ),
                SizedBox(
                  height: StyleSizes.smallIcon,
                  child: SvgPicture.asset(
                    'assets/icons/arrow_right.svg',
                    color: StyleColors.primary6,
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
