import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';

SnackBar getErrorSnackBar(BuildContext context,
    {String messageKey = 'defaultNetworkError', int durationSecond = 2}) {
  final duration = Duration(seconds: durationSecond);
  return SnackBar(
    backgroundColor: StyleColors.red6,
    duration: duration,
    content: Text(
      Intl.message('', name: messageKey),
      style: StyleFont.styleP1.merge(
        TextStyle(
          color: StyleColors.white,
        ),
      ),
    ),
  );
}
