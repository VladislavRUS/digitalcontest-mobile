import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isDisabled;
  final bool isLoading;

  Button(this.text, this.onPressed,
      {this.isDisabled = false, this.isLoading = false});

  _onPressed() {
    if (isLoading) {
      return;
    }

    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      disabledColor: AppColors.DISABLED_BUTTON_COLOR,
      padding: EdgeInsets.all(12),
      color: AppColors.BUTTON_COLOR,
      child: isLoading
          ? Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : Text(text, style: TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: isDisabled ? null : _onPressed,
    );
  }
}
