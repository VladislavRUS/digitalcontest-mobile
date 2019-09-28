import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLeadingBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: SvgPicture.asset(
          'assets/icons/chevron.svg',
          color: Colors.white,
        ));
  }
}
