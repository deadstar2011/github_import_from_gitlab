import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExampleStateful extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<ExampleStateful> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '$_counter',
          style: Theme.of(context).textTheme.headline4,
        ),
        CupertinoButton(
          child: Text('+'),
          color: Theme.of(context).accentColor,
          onPressed: _incrementCounter,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
