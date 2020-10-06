import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';

class Avatar extends StatelessWidget {
  final String firstName;
  final String middleName;

  Avatar({
    @required this.firstName,
    @required this.middleName,
  });

  String _getAbbreviation() {
    if (firstName != null && middleName != null) {
      return middleName[0] + firstName[0];
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: StyleSizes.avatar,
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          width: 2.0,
          color: StyleColors.white,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: StyleColors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            _getAbbreviation().toUpperCase(),
            style: StyleFont.styleH6.merge(
              TextStyle(color: StyleColors.primary6),
            ),
          ),
        ),
      ),
      width: StyleSizes.avatar,
    );
  }
}
