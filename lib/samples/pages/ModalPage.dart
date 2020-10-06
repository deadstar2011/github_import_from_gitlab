import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';
import 'package:optima_delivery_mobile/common/widgets/Box.dart';
import 'package:optima_delivery_mobile/common/widgets/Button.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/common/widgets/Modal.dart';
import 'package:optima_delivery_mobile/common/widgets/RadioGroup.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

class ModalPage extends StatefulWidget {
  @override
  _ModalPageState createState() => _ModalPageState();
}

class _ModalPageState extends State {
  String _picked;
  final List<RadioOption> optionList = [
    RadioOption(title: 'Клиент передумал', value: '1'),
    RadioOption(title: 'Клиент отказался частично', value: '2'),
    RadioOption(title: 'Не хватает товаров', value: '3'),
    RadioOption(title: 'Опоздал', value: '4'),
    RadioOption(title: 'Другая причина', value: '5'),
  ];

  @override
  void initState() {
    super.initState();
    _picked = null;
  }

  void handleChange(String value) {
    setState(() {
      _picked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      isAppNavigatorVisible: false,
      title: S.of(context).samplesModal,
      body: Box(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: StylePaddings.mValue,
                ),
                child: Button(
                  width: double.infinity,
                  onPressed: () async {
                    await showSpecialDialog(
                      context: context,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: SizedBox(
                            width: StyleSizes.modalWeight,
                            height: StyleSizes.modalHeight,
                            child: SvgPicture.asset(
                              'assets/images/box.svg',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            S.of(context).greatJob,
                            style: StyleFont.styleH6,
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: StyleSizes.modalContentMaxWeight,
                          ),
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            S.of(context).restDeliveries(1),
                            textAlign: TextAlign.center,
                            style: StyleFont.styleP2,
                            maxLines: 2,
                          ),
                        ),
                        Button(
                          text: S.of(context).goToDeliveriesList.toUpperCase(),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          width: double.infinity,
                        ),
                      ],
                    );
                  },
                  child: Text(S.of(context).showModal.toUpperCase()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: StylePaddings.mValue,
                ),
                child: Button(
                  width: double.infinity,
                  onPressed: () async {
                    await showSpecialDialog(
                      mainAxisAlignment: MainAxisAlignment.start,
                      context: context,
                      padding: EdgeInsets.only(
                        top: StylePaddings.lValue,
                        right: StylePaddings.lValue,
                        bottom: StylePaddings.lValue,
                      ),
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: StylePaddings.lValue),
                          child: Text(
                            (S.of(context).whatIsTheProblem),
                            style: StyleFont.styleH6,
                          ),
                        ),
                        Material(
                          child: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return RadioGroup(
                              options: optionList,
                              onChanged: (String value) {
                                setState(() {
                                  _picked = value;
                                });
                              },
                              value: _picked,
                            );
                          }),
                          color: Colors.transparent,
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Button(
                                hasShadow: false,
                                color: Colors.transparent,
                                textColor: StyleColors.primary7,
                                text: S.of(context).cancel.toUpperCase(),
                                onPressed: () {
                                  setState(() {
                                    _picked = null;
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Button(
                              text: S.of(context).save.toUpperCase(),
                              onPressed: () {
                                setState(() {
                                  _picked = null;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.end,
                        )
                      ],
                    );
                  },
                  child: Text(S.of(context).showModal.toUpperCase()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: StylePaddings.mValue,
                ),
                child: Button(
                  width: double.infinity,
                  onPressed: () async {
                    await showSpecialDialog(
                      mainAxisAlignment: MainAxisAlignment.start,
                      context: context,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Button(
                              hasShadow: false,
                              color: Colors.transparent,
                              textColor: StyleColors.primary7,
                              text: S.of(context).exit.toUpperCase(),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.end,
                        )
                      ],
                    );
                  },
                  child: Text(S.of(context).showModal.toUpperCase()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
