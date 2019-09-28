import 'package:digitalcontest_mobile/components/app_bar_title/app_bar_title.dart';
import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:digitalcontest_mobile/screens/feed/feed.dart';
import 'package:digitalcontest_mobile/screens/polls/polls.dart';
import 'package:digitalcontest_mobile/screens/profile/profile.dart';
import 'package:digitalcontest_mobile/screens/settings/settings.dart';
import 'package:flutter/material.dart';

class AppScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppScreenState();
  }
}

class AppScreenState extends State<AppScreen> {
  int currentPage = 1;
  List<Widget> pages = [
    FeedScreen(),
    PollsScreen(),
    ProfileScreen(),
    SettingsScreen()
  ];

  Widget buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: AppBarTitle('Лента'),
    );
  }

  Widget buildNavigationBarIcon(IconData iconData, int page) {
    var isActive = page == currentPage;

    return Expanded(
      child: Material(
          child: InkWell(
              onTap: () {
                setState(() {
                  currentPage = page;
                });
              },
              child: Container(
                  height: 50,
                  child: Icon(
                    iconData,
                    color: isActive ? AppColors.BUTTON_COLOR : Colors.black87,
                  )))),
    );
  }

  Widget buildNavigationBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildNavigationBarIcon(Icons.rss_feed, 0),
          buildNavigationBarIcon(Icons.question_answer, 1),
          buildNavigationBarIcon(Icons.person, 2),
          buildNavigationBarIcon(Icons.settings, 3),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: buildNavigationBar(),
    );
  }
}
