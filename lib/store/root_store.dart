import 'package:digitalcontest_mobile/store/answers_store.dart';
import 'package:digitalcontest_mobile/store/auth_store.dart';
import 'package:digitalcontest_mobile/store/polls_store.dart';
import 'package:digitalcontest_mobile/store/posts_store.dart';
import 'package:digitalcontest_mobile/store/topics_store.dart';
import 'package:requests/requests.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootStore extends Model {
  String apiHost = 'http://10.178.198.164:3000';
  bool updateTokenError = false;
  String firebaseToken;
  TopicsStore topicsStore;
  PostsStore postsStore;
  PollsStore pollsStore;
  AuthStore authStore;
  AnswersStore answersStore;

  RootStore(firebaseToken) {
    this.firebaseToken = firebaseToken;
    topicsStore = TopicsStore(this);
    postsStore = PostsStore(this);
    pollsStore = PollsStore(this);
    authStore = AuthStore(this);
    answersStore = AnswersStore(this);
  }

  getAccessToken() {
    return authStore.accessToken;
  }

  updateFirebaseToken() async {
    var url = apiHost + '/api/mobile/v1/user/update-firebase-token';
    var headers = {
      'x-access-token': getAccessToken().toString(),
      'Content-Type': 'application/json'
    };
    var body = {'firebaseToken': firebaseToken};

    try {
      await Requests.post(url, body: body, headers: headers);
      print('Updated token');
    } catch (e) {
      print(e);
      updateTokenError = true;
    }
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    clear();
  }

  clear() {
    pollsStore.clear();
    answersStore.clear();
    authStore.clear();
  }
}
