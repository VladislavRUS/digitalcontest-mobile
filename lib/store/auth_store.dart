import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:requests/requests.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStore extends Model {
  RootStore rootStore;
  bool isLoading = false;
  bool error = false;
  String accessToken;

  AuthStore(this.rootStore);

  setAccessToken(String accessToken) {
    this.accessToken = accessToken;
  }

  register(Map<String, String> body) async {
    isLoading = true;
    error = false;

    rootStore.notifyListeners();

    var url = rootStore.apiHost + '/api/mobile/v1/user/registration';

    body['firebase_token'] = rootStore.firebaseToken;

    var headers = {
      'Content-Type': 'application/json'
    };

    try {
      await Requests.post(url, body: body, headers: headers, json: true);
    } catch (e) {
      error = true;
    } finally {
      isLoading = false;
      rootStore.notifyListeners();
    }
  }

  login(Map<String, String> body) async {
    var url = rootStore.apiHost + '/api/mobile/v1/user/login';

    isLoading = true;
    rootStore.notifyListeners();

    var headers = {
      'Content-Type': 'application/json'
    };

    try {
      var response = await Requests.post(url, body: body, headers: headers, json: true);
      accessToken = response['token'];
      await saveAccessToken(accessToken);
    } catch(e) {
      print(e);
      error = true;
    } finally {
      isLoading = false;
      rootStore.notifyListeners();
    }
  }

  saveAccessToken(String accessToken) async {
    print('Token: $accessToken}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', accessToken);
  }

  clear() {
    isLoading = false;
    error = false;
    accessToken = null;

    rootStore.notifyListeners();
  }
}
