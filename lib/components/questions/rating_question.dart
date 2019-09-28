import 'package:digitalcontest_mobile/components/questions/question_title.dart';
import 'package:digitalcontest_mobile/models/question/question.dart';
import 'package:flutter/material.dart';

class RatingQuestion extends StatelessWidget {
  final Question question;
  final Function onSelectStar;
  final int selectedStarValue;

  RatingQuestion(this.question, {this.onSelectStar, this.selectedStarValue});

  Widget buildStars() {
    List<Widget> items = [];

    for (var i = 0; i < 5; i++) {
      items.add(buildStar(i));
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget buildStar(index) {
    var selectedStarIndex = selectedStarValue - 1;

    return Material(
      child: InkWell(
        onTap: () {
          onSelectStar(index + 1);
        },
        child: Icon(
          Icons.star,
          color: index <= selectedStarIndex ? Colors.yellow : Colors.grey,
          size: 50,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[QuestionTitle(question.title), buildStars()],
      ),
    );
  }
}
