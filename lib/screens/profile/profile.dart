import 'package:digitalcontest_mobile/components/app_bar_title/app_bar_title.dart';
import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:digitalcontest_mobile/constants/routes/routes.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  static RootStore of(context) => ScopedModel.of(context);

  onLogout() async {
    RootStore rootStore = of(context);
    await rootStore.logout();

    Navigator.of(context).pushNamedAndRemoveUntil(Routes.LOGIN, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.MAIN_COLOR,
        title: AppBarTitle('Профиль'),
        actions: <Widget>[
          InkWell(
            onTap: onLogout,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                'assets/icons/log-out.svg',
                color: Colors.white,
                width: 20,
                height: 20,
              ),
            ),
          )
        ],
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
