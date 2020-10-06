import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/helpers/api.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/widgets/Box.dart';
import 'package:optima_delivery_mobile/common/widgets/Button.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/common/widgets/RadioGroup.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

class UrlChangePage extends StatefulWidget {
  @override
  _UrlChangePageState createState() => _UrlChangePageState();
}

class _UrlChangePageState extends State {
  String _type = '';
  TextEditingController _controller;

  final List<RadioOption> optionList = [
    RadioOption(title: 'http', value: 'http'),
    RadioOption(title: 'https', value: 'https'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _setInitialValues();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setInitialValues() async {
    final backUrlData = await api.getBackUrlData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _type = backUrlData['scheme'] as String;
        _controller.text = backUrlData['host'] as String;
      });
    });
  }

  void handleTypeChange(String value) {
    setState(() {
      _type = value;
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
            Padding(
              padding: StylePaddings.m,
              child: Column(
                children: <Widget>[
                  Text(_type.toString()),
                  RadioGroup(
                    options: optionList,
                    onChanged: handleTypeChange,
                    value: _type,
                  ),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).changeUrl,
                    ),
                  ),
                  Button(
                    text: S.of(context).save.toUpperCase(),
                    onPressed: () {
                      api.setBackUrlData(_controller.text, _type);
                    },
                    width: double.infinity,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: StylePaddings.mValue),
                    child: Button(
                      text: S.of(context).reset.toUpperCase(),
                      onPressed: () {
                        api.setDefaultBackUrl();
                        _setInitialValues();
                      },
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
