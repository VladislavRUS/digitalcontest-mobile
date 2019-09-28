import 'package:digitalcontest_mobile/components/app_bar_title/app_bar_title.dart';
import 'package:digitalcontest_mobile/components/list_item/bottom_row_element/bottom_row_element.dart';
import 'package:digitalcontest_mobile/components/list_item/list_item.dart';
import 'package:digitalcontest_mobile/constants/app_colors/app_colors.dart';
import 'package:digitalcontest_mobile/models/post/post.dart';
import 'package:digitalcontest_mobile/models/topic/topic.dart';
import 'package:digitalcontest_mobile/store/posts_store.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:digitalcontest_mobile/store/topics_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scoped_model/scoped_model.dart';

class FeedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FeedScreenState();
  }
}

class FeedScreenState extends State<FeedScreen> {
  static RootStore of(context) =>
      ScopedModel.of<RootStore>(context, rebuildOnChange: true);

  Widget buildTopics() {
    TopicsStore topicsStore = of(context).topicsStore;

    return Container(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: topicsStore.topics.length,
          itemBuilder: (context, index) =>
              buildTopic(topicsStore.topics[index])),
    );
  }

  Widget buildTopic(Topic topic) {
    TopicsStore topicsStore = of(context).topicsStore;
    var isCurrentTopic = topic.value == topicsStore.currentTopic.value;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          topicsStore.setCurrentTopic(topic);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
              child: Text(topic.name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isCurrentTopic ? FontWeight.w600 : FontWeight.w400))),
        ),
      ),
    );
  }

  Widget buildFeed() {
    PostsStore postsStore = of(context).postsStore;

    List<Widget> items = [];
    items.add(buildTopicTitle());

    postsStore.posts.forEach((post) {
      items.add(buildPostItem(post));
    });

    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        top: 50,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items,
          ),
        ));
  }

  Widget buildPostItem(Post post) {
    Widget bottomRow = Row(
      children: <Widget>[
        BottomRowElement(post.date),
        BottomRowElement(post.likes.toString(), iconData: Icons.thumb_up),
        BottomRowElement(post.views.toString(), iconData: Icons.remove_red_eye),
        BottomRowElement(post.comments.toString(), iconData: Icons.textsms),
      ],
    );

    return ListItem(true, post.imageUrl, post.title, bottomRow);
  }

  Widget buildTopicTitle() {
    TopicsStore topicsStore = of(context).topicsStore;

    return Container(
        margin: EdgeInsets.only(left: 20, top: 20),
        child: Text(topicsStore.currentTopic.name,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.MAIN_COLOR,
        title: AppBarTitle('Лента'),
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                'assets/icons/search.svg',
                color: Colors.white,
                width: 20,
                height: 20,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[buildTopics(), buildFeed()],
        ),
      ),
    );
  }
}
