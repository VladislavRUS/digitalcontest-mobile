import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String text;

  AppBarTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(this.text,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white));
  }
}
