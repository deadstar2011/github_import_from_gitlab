import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';

class InfoItem extends StatelessWidget {
  final String svgPath;
  final String label;
  final String value;
  final Color iconColor;
  final void Function() onTap;

  InfoItem({
    @required this.svgPath,
    @required this.label,
    @required this.value,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: StyleColors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: StylePaddings.mValue,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: StylePaddings.xlValue,
                  right: StylePaddings.xlValue,
                  top: StylePaddings.xxsValue,
                ),
                child: SvgPicture.asset(
                  svgPath,
                  color: iconColor,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right: StylePaddings.xlValue),
                  child: Column(
                    children: <Widget>[
                      Text(
                        label,
                        style: StyleFont.styleCaption.merge(
                          TextStyle(
                            color: StyleColors.graphite4,
                          ),
                        ),
                      ),
                      Text(
                        value != '' && value != null ? value : '\u2014',
                        style: StyleFont.styleP1,
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
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
