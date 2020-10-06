import 'package:flutter/material.dart';

class TooltipShapeBorder extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double arrowArc;
  final double radius;
  final double leftOffsetCoefficient;

  TooltipShapeBorder({
    this.radius = 4.0,
    this.arrowWidth = 9.0,
    this.arrowHeight = 5.0,
    this.arrowArc = 0.0,
    this.leftOffsetCoefficient = 4,
  }) : assert(arrowArc <= 1.0 && arrowArc >= 0.0);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    rect = Rect.fromPoints(
        rect.topLeft, rect.bottomRight - Offset(0, arrowHeight));
    final x = arrowWidth;
    final y = arrowHeight;
    final r = 1 - arrowArc;
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(
          rect.topLeft.dx +
              (rect.topCenter.dx - rect.topLeft.dx) / leftOffsetCoefficient +
              x / 2,
          rect.topCenter.dy)
      ..relativeLineTo(-x / 2 * r, -y * r)
      ..relativeQuadraticBezierTo(
          -x / 2 * (1 - r), -y * (1 - r), -x * (1 - r), 0)
      ..relativeLineTo(-x / 2 * r, y * r);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
