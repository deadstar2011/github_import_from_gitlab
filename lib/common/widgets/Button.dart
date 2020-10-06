import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/shadows.dart';

class Button extends Container {
  Button({
    Widget child,
    Color color = StyleColors.primary7,
    Color disabledColor = StyleColors.primary4,
    Color disabledTextColor = StyleColors.white,
    double height,
    void Function() onPressed,
    EdgeInsets padding,
    String text = '',
    Color textColor = StyleColors.white,
    TextStyle textStyle = StyleFont.styleButton,
    bool hasShadow = true,
    double width,
  }) : super(
          child: FlatButton(
            child: child ??
                Text(
                  text,
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
            color: color,
            disabledColor: disabledColor,
            disabledTextColor: disabledTextColor,
            onPressed: onPressed,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: padding ??
                EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
            textColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                4.0,
              ),
            ),
          ),
          decoration: BoxDecoration(
            boxShadow: hasShadow ? [StyleShadows.shadow] : [],
          ),
          height: height,
          width: width,
        );
}
