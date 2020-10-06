import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';

Future<BitmapDescriptor> getMarkerIcon(
  Color color,
  int width,
  int borderWidth,
  bool isActive,
) async {
  final pictureRecorder = ui.PictureRecorder();
  final canvas = Canvas(pictureRecorder);
  final paintMain = Paint()..color = color;
  final paintWhite = Paint()..color = StyleColors.white;

  final radius = width / 2;

  canvas.drawCircle(
    Offset(radius, radius),
    radius,
    paintMain,
  );

  if (!isActive) {
    canvas.drawCircle(
      Offset(radius, radius),
      radius - borderWidth,
      paintWhite,
    );
  }

  final image = await pictureRecorder.endRecording().toImage(
        width,
        width,
      );

  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}

Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(BuildContext context,
    String assetName, int iconHeight, int iconWeight) async {
  final svgString = await DefaultAssetBundle.of(context).loadString(assetName);

  final svgDrawableRoot = await svg.fromSvgString(svgString, null);

  final queryData = MediaQuery.of(context);
  final devicePixelRatio = queryData.devicePixelRatio;
  final width = iconHeight * devicePixelRatio;
  final height = iconWeight * devicePixelRatio;

  final picture = svgDrawableRoot.toPicture(size: Size(width, height));

  final image = await picture.toImage(width.toInt(), height.toInt());
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
}
