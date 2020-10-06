import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/styles/shadows.dart';

Future<dynamic> showSpecialDialog({
  @required BuildContext context,
  @required List<Widget> children,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
  EdgeInsets padding = StylePaddings.l,
}) async {
  return showDialog<dynamic>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Container(
        color: StyleColors.white90,
        child: Dialog(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                StyleShadows.shadow,
              ],
              color: StyleColors.white,
            ),
            child: Container(
              margin: padding,
              child: Column(
                mainAxisAlignment: mainAxisAlignment,
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
            ),
          ),
          elevation: 0.0,
          insetPadding: EdgeInsets.only(
            left: StylePaddings.sValue,
            right: StylePaddings.sValue,
          ),
          insetAnimationDuration: Duration(milliseconds: 400),
        ),
      );
    },
  );
}
