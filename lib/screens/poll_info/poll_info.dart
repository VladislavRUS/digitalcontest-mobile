import 'package:digitalcontest_mobile/components/app_bar_title/app_bar_title.dart';
import 'package:digitalcontest_mobile/components/app_leading_back/app_leading_back.dart';
import 'package:digitalcontest_mobile/components/button/button.dart';
import 'package:digitalcontest_mobile/store/polls_store.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PollInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PollInfoScreenState();
  }
}

class PollInfoScreenState extends State<PollInfoScreen> {
  static RootStore of(context) => ScopedModel.of(context);

  Widget buildTitle() {
    PollsStore pollsStore = of(context).pollsStore;

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Text(
        pollsStore.currentPoll.title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget buildDescription() {
    PollsStore pollsStore = of(context).pollsStore;

    if (pollsStore.currentPoll.text == null) {
      return null;
    }

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Text(pollsStore.currentPoll.text, style: TextStyle(fontSize: 16)),
    );
  }

  Widget buildImage() {
    PollsStore pollsStore = of(context).pollsStore;

    if (pollsStore.currentPoll.image == null) {
      return null;
    }

    var imageUrl = pollsStore.currentPoll.image;

    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Hero(
            tag: imageUrl, child: Image.network(imageUrl, fit: BoxFit.cover)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        leading: AppLeadingBack(),
        backgroundColor: Colors.white,
        title: AppBarTitle('Опрос'),
      ),
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildImage(),
                    buildTitle(),
                    buildDescription()
                  ].where((widget) => widget != null).toList(),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Button('Пройти опрос', () {}),
            )
          ],
        ),
      ),
    );
  }
}
