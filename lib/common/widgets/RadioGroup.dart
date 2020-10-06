import 'package:flutter/material.dart';

class RadioOption {
  String title;
  String value;

  RadioOption({this.title, this.value});
}

class RadioGroup extends StatelessWidget {
  final List<RadioOption> options;
  final String value;
  final Function onChanged;

  RadioGroup({
    this.options = const [],
    @required this.value,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options
          .map(
            (RadioOption item) => RadioListTile<String>(
              value: item.value,
              groupValue: value,
              onChanged: (String val) {
                if (null != onChanged) {
                  onChanged(val);
                }
              },
              title: Text(
                item.title,
              ),
            ),
          )
          .toList(),
    );
  }
}
