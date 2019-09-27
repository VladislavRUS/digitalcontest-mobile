import 'package:digitalcontest_mobile/store/polls_store.dart';
import 'package:digitalcontest_mobile/store/posts_store.dart';
import 'package:digitalcontest_mobile/store/topics_store.dart';
import 'package:scoped_model/scoped_model.dart';

class RootStore extends Model {
  TopicsStore topicsStore;
  PostsStore postsStore;
  PollsStore pollsStore;

  RootStore() {
    topicsStore = TopicsStore(this);
    postsStore = PostsStore(this);
    pollsStore = PollsStore(this);
  }
}
