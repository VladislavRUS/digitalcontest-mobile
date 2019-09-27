import 'package:digitalcontest_mobile/components/app_bar_title/app_bar_title.dart';
import 'package:digitalcontest_mobile/components/list_item/bottom_row_element/bottom_row_element.dart';
import 'package:digitalcontest_mobile/components/list_item/list_item.dart';
import 'package:digitalcontest_mobile/constants/routes/routes.dart';
import 'package:digitalcontest_mobile/models/poll/poll.dart';
import 'package:digitalcontest_mobile/store/polls_store.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PollsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PollsScreenState();
  }
}

class PollsScreenState extends State<PollsScreen> {
  static RootStore of(context) => ScopedModel.of<RootStore>(context);

  Widget buildList() {
    PollsStore pollsStore = of(context).pollsStore;

    return ListView.builder(
        itemCount: pollsStore.polls.length,
        itemBuilder: (context, index) {
          return buildPollItem(pollsStore.polls[index]);
        });
  }

  Widget buildPollItem(Poll poll) {
    PollsStore pollsStore = of(context).pollsStore;

    Widget bottomRow = Row(
      children: <Widget>[BottomRowElement('26 сент.')],
    );

    return ListItem(false, poll.image, poll.title, bottomRow, onTap: () {
      pollsStore.setCurrentPoll(poll);
      Navigator.of(context).pushNamed(Routes.POLL_INFO);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: AppBarTitle('Опросы'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: buildList(),
      ),
    );
  }
}
