import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/widgets/TooltipShape.dart';

class StyledTooltip extends StatelessWidget {
  final Widget child;
  final String message;
  final EdgeInsets margin;

  StyledTooltip({
    @required this.child,
    this.margin = const EdgeInsets.all(0.0),
    @required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      margin: margin,
      padding: StylePaddings.xs,
      decoration: ShapeDecoration(
        color: StyleColors.primary6,
        shape: TooltipShapeBorder(),
      ),
      message: message,
      textStyle: StyleFont.styleOverLine.merge(
        TextStyle(
          color: StyleColors.white,
        ),
      ),
      child: child,
      waitDuration: Duration(milliseconds: 1),
    );
  }
}
