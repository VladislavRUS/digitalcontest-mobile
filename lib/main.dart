import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:digitalcontest_mobile/constants/routes/routes.dart';
import 'package:digitalcontest_mobile/screens/app/app.dart';
import 'package:digitalcontest_mobile/screens/initial/initial.dart';
import 'package:digitalcontest_mobile/screens/login/login.dart';
import 'package:digitalcontest_mobile/screens/poll/poll.dart';
import 'package:digitalcontest_mobile/screens/poll_info/poll_info.dart';
import 'package:digitalcontest_mobile/screens/register/register.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  const defaultLocale = 'ru_RU';
  Intl.defaultLocale = defaultLocale;
  initializeDateFormatting(defaultLocale);

  var firebaseToken = await _firebaseMessaging.getToken();

  RootStore rootStore = RootStore(firebaseToken);

  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      rootStore.pollsStore.fetchPolls();
    },
    onLaunch: (Map<String, dynamic> message) async {
      rootStore.pollsStore.fetchPolls();
    },
    onResume: (Map<String, dynamic> message) async {
      rootStore.pollsStore.fetchPolls();
    },
  );

  runApp(ScopedModel(
    model: rootStore,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
          canvasColor: Colors.white,
          primaryColor: AppColors.MAIN_COLOR,
          unselectedWidgetColor: AppColors.GREY_COLOR),
      initialRoute: Routes.INITIAL,
      routes: {
        Routes.INITIAL: (_) => InitialScreen(),
        Routes.APP: (_) => AppScreen(),
        Routes.POLL_INFO: (_) => PollInfoScreen(),
        Routes.LOGIN: (_) => LoginScreen(),
        Routes.REGISTER: (_) => RegisterScreen(),
        Routes.POLL: (_) => PollScreen(),
      },
    );
  }
}
