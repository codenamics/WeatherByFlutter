import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  final String text;
  Test({@required this.text});

  Widget build(BuildContext context) {
    return Container(
      child: Text(this.text),
    );
  }
}
