import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:digitalcontest_mobile/constants/routes/routes.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InitialScreenState();
  }
}

class InitialScreenState extends State<InitialScreen> {
  static RootStore of(context) => ScopedModel.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    'assets/icons/app_icon.png',
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Загрузка...',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.TEXT_COLOR),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(init);
  }

  init(_) async {
    await Future.delayed(Duration(milliseconds: 500));

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var accessToken = prefs.getString('access_token');

    if (accessToken == null) {
      Navigator.of(context).pushReplacementNamed(Routes.LOGIN);
    } else {
      RootStore rootStore = of(context);
      rootStore.clear();
      rootStore.authStore.setAccessToken(accessToken);

      await rootStore.updateFirebaseToken();

      if (rootStore.updateTokenError) {
        Navigator.of(context).pushReplacementNamed(Routes.LOGIN);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.APP);
      }
    }
  }
}
