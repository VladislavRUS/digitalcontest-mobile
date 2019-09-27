import 'package:digitalcontest_mobile/constants/routes/routes.dart';
import 'package:digitalcontest_mobile/screens/app/app.dart';
import 'package:digitalcontest_mobile/screens/poll_info/poll_info.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void main() async {

  print(await _firebaseMessaging.getToken());

  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    },
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    },
  );

  RootStore rootStore = RootStore();
  runApp(ScopedModel(
    model: rootStore,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.APP,
      routes: {
        Routes.APP: (_) => AppScreen(),
        Routes.POLL_INFO: (_) => PollInfoScreen(),
      },
    );
  }
}
