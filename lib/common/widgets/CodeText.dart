import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';

class CodeText extends StatelessWidget {
  final bool isError;
  final String value;
  final int length;

  CodeText({
    this.isError = false,
    @required this.value,
    this.length = 4,
  });

  List<Widget> _renderCode() {
    var codeCharList = value != null ? value.split('') : <String>[];
    var textList = <Widget>[];

    for (var i = 0; i < length; i++) {
      textList.add(
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(
            horizontal: 2,
          ),
          width: StyleSizes.codeCharWidth,
          height: StyleSizes.codeCharHeight,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: StyleColors.primary6,
                width: 1,
              ),
            ),
          ),
          child: Text(
            codeCharList.isNotEmpty && codeCharList.length > i
                ? codeCharList[i]
                : '',
            style: StyleFont.styleH5.merge(
              TextStyle(
                color: isError ? StyleColors.red5 : StyleColors.primary6,
              ),
            ),
          ),
        ),
      );
    }

    return textList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _renderCode(),
    );
  }
}
