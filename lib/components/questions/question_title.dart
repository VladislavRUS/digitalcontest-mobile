import 'package:flutter/material.dart';

class QuestionTitle extends StatelessWidget {
  final String text;

  QuestionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
    );
  }
}