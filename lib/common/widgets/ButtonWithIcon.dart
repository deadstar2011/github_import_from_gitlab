import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';

class ButtonWithIcon extends StatelessWidget {
  final String svgPath;
  final String label;
  final Color backgroundColor;
  final void Function() onPressed;

  ButtonWithIcon({
    @required this.svgPath,
    @required this.label,
    this.backgroundColor = StyleColors.white,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Ink(
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: SvgPicture.asset(
              svgPath,
            ),
            onPressed: onPressed,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10.0,
          ),
          child: Text(
            label,
            style: StyleFont.styleCaption.merge(
              TextStyle(
                color: StyleColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
