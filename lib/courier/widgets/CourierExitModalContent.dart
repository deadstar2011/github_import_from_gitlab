import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/widgets/Button.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class CourierExitModalContent extends StatelessWidget {
  final void Function() onYesTab;
  final void Function() onNoTab;
  final String dispatcherPhone;

  CourierExitModalContent(
      {this.onNoTab, this.onYesTab, @required this.dispatcherPhone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            bottom: StylePaddings.xlValue,
          ),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: S.of(context).exitMessage,
                  style: StyleFont.styleSubtitle1,
                ),
                TextSpan(
                  text: S.of(context).exitCallToDispatcher,
                  style: StyleFont.styleSubtitle1.merge(
                    TextStyle(
                      color: StyleColors.primary6,
                    ),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      if (dispatcherPhone != null &&
                          await canLaunch('tel:$dispatcherPhone')) {
                        await launch('tel:$dispatcherPhone');
                      }
                    },
                ),
              ],
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: StylePaddings.xsValue,
              ),
              child: Button(
                hasShadow: false,
                color: Colors.transparent,
                textColor: StyleColors.primary7,
                text: S.of(context).cancel.toUpperCase(),
                onPressed: onNoTab ??
                    () {
                      Navigator.pop(context, false);
                    },
              ),
            ),
            Button(
              hasShadow: false,
              color: Colors.transparent,
              textColor: StyleColors.primary7,
              text: S.of(context).exit.toUpperCase(),
              onPressed: onYesTab ??
                  () {
                    Navigator.pop(context, true);
                  },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        )
      ],
    );
  }
}
