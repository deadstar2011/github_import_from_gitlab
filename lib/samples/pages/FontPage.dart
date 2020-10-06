import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/widgets/Box.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

class FontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      isAppNavigatorVisible: false,
      title: S.of(context).samplesFonts,
      body: Box(children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              S.of(context).headerTitle,
              style: StyleFont.styleH4,
            ),
            Text(
              S.of(context).headerTitle,
              style: StyleFont.styleH5,
            ),
            Text(
              S.of(context).headerTitle,
              style: StyleFont.styleH6,
            ),
            Text(
              S.of(context).headerTitle,
              style: StyleFont.styleSubtitle1,
            ),
            Text(
              S.of(context).headerTitle,
              style: StyleFont.styleSubtitle2,
            ),
            Text(
              S.of(context).headerTitle,
              style: StyleFont.styleP1,
            ),
            Text(
              S.of(context).headerTitle,
              style: StyleFont.styleP2,
            ),
            Text(
              S.of(context).headerTitle,
              style: StyleFont.styleButton.merge(
                TextStyle(color: StyleColors.primary6),
              ),
            ),
            Text(
              S.of(context).headerTitle,
              style: StyleFont.styleCaption,
            ),
            Text(
              S.of(context).headerTitle,
              style: StyleFont.styleOverLine,
            ),
          ],
        ),
      ]),
    );
  }
}
