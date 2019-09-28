import 'package:digitalcontest_mobile/components/button/button.dart';
import 'package:digitalcontest_mobile/constants/routes/routes.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: <Widget>[Button('Выйти', onLogout)],
      ),
    );
  }
}
