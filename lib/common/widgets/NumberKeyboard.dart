import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  final TextStyle textStyle;
  final Widget rightIcon;
  final Function() onTapRightButton;
  final Widget leftIcon;
  final Function() onTapLeftButton;
  final KeyboardTapCallback onKeyboardTap;
  final MainAxisAlignment mainAxisAlignment;

  NumericKeyboard({
    @required this.onKeyboardTap,
    this.textStyle,
    this.onTapRightButton,
    this.rightIcon,
    this.onTapLeftButton,
    this.leftIcon,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  Widget _renderButton(String value) {
    return InkWell(
      borderRadius: BorderRadius.circular(45),
      onTap: () {
        widget.onKeyboardTap(value);
      },
      child: Container(
        alignment: Alignment.center,
        width: StyleSizes.numberKeyWeight,
        height: StyleSizes.numberKeyHeight,
        margin: EdgeInsets.symmetric(vertical: StylePaddings.mValue),
        child: Text(
          value,
          style: widget.textStyle ??
              StyleFont.styleH4.merge(
                TextStyle(
                  color: StyleColors.primary6,
                ),
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            buttonPadding: EdgeInsets.all(0.0),
            children: <Widget>[
              _renderButton('1'),
              _renderButton('2'),
              _renderButton('3'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            buttonPadding: EdgeInsets.all(0.0),
            children: <Widget>[
              _renderButton('4'),
              _renderButton('5'),
              _renderButton('6'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            buttonPadding: EdgeInsets.all(0.0),
            children: <Widget>[
              _renderButton('7'),
              _renderButton('8'),
              _renderButton('9'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            buttonPadding: EdgeInsets.all(0.0),
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(45),
                onTap: widget.onTapLeftButton,
                child: Container(
                  alignment: Alignment.center,
                  width: StyleSizes.numberKeyWeight,
                  height: StyleSizes.numberKeyHeight,
                  margin: EdgeInsets.symmetric(vertical: StylePaddings.mValue),
                  child: widget.leftIcon,
                ),
              ),
              _renderButton('0'),
              InkWell(
                borderRadius: BorderRadius.circular(45),
                onTap: widget.onTapRightButton,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: StylePaddings.mValue),
                  alignment: Alignment.center,
                  width: StyleSizes.numberKeyWeight,
                  height: StyleSizes.numberKeyHeight,
                  child: widget.rightIcon,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
