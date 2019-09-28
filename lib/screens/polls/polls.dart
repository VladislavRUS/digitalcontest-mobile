import 'package:digitalcontest_mobile/components/app_bar_title/app_bar_title.dart';
import 'package:digitalcontest_mobile/components/list_item/bottom_row_element/bottom_row_element.dart';
import 'package:digitalcontest_mobile/components/list_item/list_item.dart';
import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:digitalcontest_mobile/constants/routes/routes.dart';
import 'package:digitalcontest_mobile/models/poll/poll.dart';
import 'package:digitalcontest_mobile/store/polls_store.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

class PollsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PollsScreenState();
  }
}

class PollsScreenState extends State<PollsScreen> {
  static RootStore of(context) =>
      ScopedModel.of<RootStore>(context, rebuildOnChange: true);

  Widget buildList() {
    PollsStore pollsStore = of(context).pollsStore;

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        await forceUpdate();
      },
      child: ListView.builder(
          itemCount: pollsStore.polls.length,
          itemBuilder: (context, index) {
            return buildPollItem(pollsStore.polls[index]);
          }),
    );
  }

  Widget buildPollItem(Poll poll) {
    PollsStore pollsStore = of(context).pollsStore;

    DateTime creationDate =
        DateTime.fromMillisecondsSinceEpoch(poll.creationDate);
    String formattedDate = DateFormat('dd MMMM yyyy').format(creationDate);

    Widget bottomRow = Row(
      children: <Widget>[BottomRowElement(formattedDate)],
    );

    return ListItem(false, poll.image, poll.title, bottomRow, onTap: () {
      pollsStore.setCurrentPoll(poll);
      Navigator.of(context).pushNamed(Routes.POLL_INFO);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(init);
  }

  init(_) async {
    PollsStore pollsStore = of(context).pollsStore;

    if (pollsStore.polls.length == 0) {
      await pollsStore.fetchPolls();
    }

    await pollsStore.fetchFinishedPolls();
  }

  forceUpdate() async {
    PollsStore pollsStore = of(context).pollsStore;

    await pollsStore.fetchPolls();
    await pollsStore.fetchFinishedPolls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.MAIN_COLOR,
        title: AppBarTitle('Опросы'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: buildList(),
      ),
    );
  }
}
