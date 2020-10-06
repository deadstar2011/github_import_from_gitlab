import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';

const Map<String, Color> StatusColorMap = {
  'notify': StyleColors.graphite4,
  'error': StyleColors.red6,
};

class StatusBanner extends StatelessWidget {
  final bool isVisible;
  final String type;
  final String message;
  final void Function() onPressed;

  StatusBanner({
    @required this.isVisible,
    @required this.type,
    @required this.message,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isVisible != null && isVisible) {
      return Padding(
        padding: const EdgeInsets.only(
          top: StylePaddings.xsValue,
          left: StylePaddings.xsValue,
          right: StylePaddings.xsValue,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: StatusColorMap[type] ?? StyleColors.red6,
            borderRadius: BorderRadius.all(
              Radius.circular(3.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/close.svg',
                ),
                onPressed: onPressed,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: StylePaddings.mValue,
                    top: StylePaddings.mValue,
                    right: StylePaddings.mValue,
                  ),
                  child: Text(
                    message,
                    overflow: TextOverflow.ellipsis,
                    style: StyleFont.styleOverLine.merge(
                      TextStyle(
                        color: StyleColors.white,
                      ),
                    ),
                    maxLines: 3,
                    softWrap: false,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Container();
  }
}
