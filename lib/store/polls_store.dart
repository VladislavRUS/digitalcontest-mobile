import 'package:digitalcontest_mobile/models/finished_poll/finished_poll.dart';
import 'package:digitalcontest_mobile/models/poll/poll.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:requests/requests.dart';
import 'package:scoped_model/scoped_model.dart';

var jsonPoll = {
  'id': '1',
  'title': 'Выбор нового герба ЦБ',
  'text': 'Мы хотим выбрать новый герб ЦБ. Скажите, нравится ли он вам',
  'image':
      'https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  'video': '',
  'geo': {'lat': 33.0, 'lng': 35.0},
  'questions': [
    {
      '_id': '1',
      'title': 'Вам нравится новый герб?',
      'type': 'select',
      'options': [
        'Да',
        'Нет',
      ]
    },
    {
      '_id': '2',
      'title': 'Оцените новый герб',
      'type': 'rating',
      'options': []
    },
    {
      '_id': '3',
      'title': 'Оставьте комментарий',
      'type': 'text'
    }
  ]
};

class PollsStore extends Model {
  RootStore rootStore;
  List<Poll> polls = [];
  List<String> finishedPolls = [];
  Poll currentPoll;
  bool isLoading = false;
  bool error = false;

  PollsStore(this.rootStore);

  setCurrentPoll(Poll poll) {
    currentPoll = poll;
    rootStore.answersStore.answers.clear();
    rootStore.notifyListeners();
  }

  fetchPolls() async {
    error = true;
    isLoading = true;

    rootStore.notifyListeners();

    var url = rootStore.apiHost + '/api/mobile/v1/poll/get-list';
    var headers = {'x-access-token': rootStore.getAccessToken().toString()};

    try {
      var jsonPolls = await Requests.get(url, headers: headers, json: true);
      for (var i = 0; i < jsonPolls.length; i++) {
        jsonPolls[i] = await fetchQuestions(jsonPolls[i]['_id']);
      }

      polls = [];

      jsonPolls.forEach((jsonPoll) {
        polls.add(Poll.fromJson(jsonPoll));
      });

      print('Loaded polls: ${polls.length}');
    } catch (e) {
      print(e);
      error = true;
    } finally {
      isLoading = false;
      rootStore.notifyListeners();
    }
  }

  fetchQuestions(String pollId) async {
    var url = rootStore.apiHost + '/api/mobile/v1/poll/detail/$pollId';
    var headers = {'x-access-token': rootStore.getAccessToken().toString()};
    return await Requests.get(url, headers: headers, json: true);
  }

  fetchFinishedPolls() async {
    error = true;
    isLoading = true;

    rootStore.notifyListeners();

    var url = rootStore.apiHost + '/api/mobile/v1/poll/get-completed-list';
    var headers = {'x-access-token': rootStore.getAccessToken().toString()};

    try {
      var jsonFinishedPolls = await Requests.get(url, headers: headers, json: true);

      jsonFinishedPolls.forEach((jsonFinishedPoll) {
        finishedPolls.add(jsonFinishedPoll['poll_id']);
      });

      print('Loaded finished polls: ${finishedPolls.length}');
    } catch (e) {
      print(e);
      error = true;
    } finally {
      isLoading = false;
      rootStore.notifyListeners();
    }
  }

  clear() {
    polls = [];
    finishedPolls = [];
    currentPoll = null;
    isLoading = false;
    error = false;

    rootStore.notifyListeners();
  }
}
