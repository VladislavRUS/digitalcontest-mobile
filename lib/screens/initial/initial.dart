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
      body: Text('InitialScreenState'),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(init);
  }

  init(_) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var accessToken = prefs.getString('access_token');

    print(accessToken);

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