import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType inputType;
  final Function onChanged;

  Input(this.controller,
      {this.label, this.inputType = TextInputType.text, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
          labelText: label, labelStyle: TextStyle(color: AppColors.TEXT_COLOR, fontSize: 14)),
    );
  }
}
