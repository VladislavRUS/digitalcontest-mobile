import 'package:digitalcontest_mobile/components/app_bar_title/app_bar_title.dart';
import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:digitalcontest_mobile/screens/feed/feed.dart';
import 'package:digitalcontest_mobile/screens/polls/polls.dart';
import 'package:digitalcontest_mobile/screens/profile/profile.dart';
import 'package:digitalcontest_mobile/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  Widget buildNavigationBarIcon(String asset, int page) {
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
                  child: Center(
                    child: Container(
                      width: 25,
                      height: 25,
                      child: SvgPicture.asset(
                        asset,
                        color: isActive
                            ? AppColors.BUTTON_COLOR
                            : AppColors.ICON_INACTIVE_COLOR,
                      ),
                    ),
                  )))),
    );
  }

  Widget buildNavigationBar() {
    return Container(
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildNavigationBarIcon('assets/icons/rss.svg', 0),
          buildNavigationBarIcon('assets/icons/bell.svg', 1),
          buildNavigationBarIcon('assets/icons/user.svg', 2),
          buildNavigationBarIcon('assets/icons/settings.svg', 3),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentPage], bottomNavigationBar: buildNavigationBar());
  }
}
