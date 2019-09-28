import 'package:digitalcontest_mobile/components/questions/question_title.dart';
import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:digitalcontest_mobile/models/question/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectQuestion extends StatelessWidget {
  final Question question;
  final String selectedOption;
  final Function onOptionSelect;

  SelectQuestion(this.question, {this.selectedOption, this.onOptionSelect});

  Widget buildOptions() {
    List<Widget> items = [];

    question.options.forEach((option) {
      items.add(buildOption(option));
    });

    return Column(
      children: items,
    );
  }

  Widget buildOption(String option) {
    var isSelected = option == selectedOption;

    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5),
      child: Material(
        color: AppColors.SCAFFOLD_BG,
        child: InkWell(
          onTap: () {
            onOptionSelect(option);
          },
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    option,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Spacer(),
                isSelected
                    ? SvgPicture.asset(
                        'assets/icons/check.svg',
                      )
                    : null
              ].where((widget) => widget != null).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[QuestionTitle(question.title), buildOptions()],
      ),
    );
  }
}
