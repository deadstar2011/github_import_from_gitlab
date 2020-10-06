import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final List<Widget> children;

  Box({this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: children
          .map(
            (child) => Expanded(
              child: Container(
                child: child,
              ),
            ),
          )
          .toList(),
    );
  }
}
