import 'package:digitalcontest_mobile/components/app_bar_title/app_bar_title.dart';
import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsScreenState();
  }
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.MAIN_COLOR,
        title: AppBarTitle('Настройки'),
      ),
      body: Center(
        child: Container(
            child: Text(
          'Раздел находится в разработке',
          style: TextStyle(color: AppColors.TEXT_COLOR, fontSize: 14),
        )),
      ),
    );
  }
}
