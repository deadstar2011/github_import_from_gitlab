import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/widgets/Box.dart';
import 'package:optima_delivery_mobile/common/widgets/Button.dart';
import 'package:optima_delivery_mobile/common/widgets/CodeText.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/common/widgets/NumberKeyboard.dart';
import 'package:optima_delivery_mobile/common/widgets/RadioGroup.dart';
import 'package:optima_delivery_mobile/common/widgets/StyledTooltip.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class ControlPage extends StatefulWidget {
  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State {
  String _picked = '';
  String _numbers = '';
  bool isError = false;

  final List<RadioOption> optionList = [
    RadioOption(title: 'Первый', value: '1'),
    RadioOption(title: 'Второй', value: '2'),
    RadioOption(title: 'Третий', value: '3'),
  ];

  void handleChange(String value) {
    setState(() {
      _picked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      isAppNavigatorVisible: false,
      title: S.of(context).samplesControl,
      body: SingleChildScrollView(
        child: Box(
          children: <Widget>[
            Column(
              children: <Widget>[
                Button(
                  text: S.of(context).headerTitle.toUpperCase(),
                  onPressed: () {},
                  width: double.infinity,
                ),
                StyledTooltip(
                  margin: EdgeInsets.only(
                    left: 50.0,
                  ),
                  message: S.of(context).helpTooltip,
                  child: Button(
                    hasShadow: false,
                    color: Colors.transparent,
                    textColor: StyleColors.primary7,
                    text: S.of(context).headerTitle.toUpperCase(),
                    onPressed: () {},
                  ),
                ),
                Text(_picked.toString()),
                RadioGroup(
                  options: optionList,
                  onChanged: handleChange,
                  value: _picked,
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: StylePaddings.mValue,
                  ),
                  alignment: Alignment.topCenter,
                  child: Text(
                    isError ? S.of(context).badCode : S.of(context).writeCode,
                    textAlign: TextAlign.center,
                    style: StyleFont.styleP1.merge(
                      TextStyle(
                        color: StyleColors.graphite7,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: StylePaddings.xlValue,
                  ),
                  child: CodeText(
                    isError: isError,
                    value: _numbers,
                    length: 13,
                  ),
                ),
                NumericKeyboard(
                  onKeyboardTap: (String number) {
                    if (_numbers.length < 13) {
                      setState(() {
                        _numbers = _numbers + number;
                        isError = false;
                      });
                    }
                    if (_numbers.length > 12) {
                      setState(() {
                        isError = true;
                      });
                    }
                  },
                  leftIcon: SvgPicture.asset(
                    'assets/icons/dispatcher.svg',
                    color: StyleColors.graphite4,
                  ),
                  rightIcon: SvgPicture.asset(
                    'assets/icons/backspace.svg',
                    color: StyleColors.graphite4,
                  ),
                  onTapRightButton: () {
                    setState(() {
                      _numbers = _numbers.substring(0, _numbers.length - 1);
                      isError = false;
                    });
                  },
                  onTapLeftButton: () async {
                    final phoneNumber = '+79011231212';
                    if (await canLaunch('tel:$phoneNumber')) {
                      await launch('tel:$phoneNumber');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
