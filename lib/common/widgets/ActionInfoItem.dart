import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';

class ActionInfoItem extends StatelessWidget {
  final String svgPath;
  final void Function() onPressed;
  final String value;
  final String comment;
  final TextStyle commentStyle;

  ActionInfoItem({
    @required this.svgPath,
    @required this.onPressed,
    @required this.value,
    this.comment,
    this.commentStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: StyleColors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.only(
              top: StylePaddings.mValue,
              bottom: StylePaddings.mValue,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    left: StylePaddings.xlValue,
                    right: StylePaddings.xlValue,
                  ),
                  child: SvgPicture.asset(
                    svgPath,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                value,
                                style: StyleFont.styleP1,
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: StylePaddings.xlValue,
                              ),
                              child: onPressed != null
                                  ? Container(
                                      alignment: Alignment.centerRight,
                                      child: SvgPicture.asset(
                                        'assets/icons/arrow_right.svg',
                                      ),
                                    )
                                  : Container(),
                            ),
                          ),
                        ],
                      ),
                      if (comment != null)
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            comment,
                            style: commentStyle,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
