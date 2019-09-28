import 'package:digitalcontest_mobile/components/questions/question_title.dart';
import 'package:digitalcontest_mobile/models/question/question.dart';
import 'package:flutter/material.dart';

class TextQuestion extends StatelessWidget {
  final Question question;
  final Function onTextChange;
  final String text;

  TextQuestion(this.question, {this.onTextChange, this.text});

  Widget buildTextField() {
    return Container(
      child: TextField(
        maxLines: 2,
        onChanged: onTextChange,
        decoration: InputDecoration(hintText: 'Введите текст'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[QuestionTitle(question.title), buildTextField()],
      ),
    );
  }
}
