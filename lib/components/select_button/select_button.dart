import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  final List<String> options;
  final String activeOption;
  final Function onOption;

  SelectButton(this.options, this.activeOption, this.onOption);

  List<Widget> buildOptions() {
    List<Widget> widgets = [];

    options.forEach((option) {
      widgets.add(buildOption(option));
    });

    return widgets;
  }

  Widget buildOption(String option) {
    return Expanded(
      child: Material(
        color:
            option == activeOption ? AppColors.MAIN_COLOR : Colors.transparent,
        child: InkWell(
          onTap: () {
            onOption(option);
          },
          child: Container(
            child: Center(
              child: Text(
                option,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 197, 197, 197),
      height: 50,
      child: Row(
        children: buildOptions(),
      ),
    );
  }
}
