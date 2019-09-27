import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;

  Button(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(12),
      color: AppColors.BUTTON_COLOR,
      child: Text(text, style: TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: onPressed,
    );
  }
}
