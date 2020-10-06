import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

class ExampleStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).exampleStatelessTitle,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
