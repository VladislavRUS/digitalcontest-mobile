import 'package:digitalcontest_mobile/models/poll/poll.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
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
      'id': '1',
      'title': 'Вам нравится новый герб?',
      'type': 'select',
      'options': [
        {'id': '1', 'text': 'Да'},
        {'id': '2', 'text': 'Нет'},
      ]
    }
  ]
};

class PollsStore extends Model {
  RootStore rootStore;
  List<Poll> polls = [];
  Poll currentPoll;

  PollsStore(RootStore rootStore) {
    this.rootStore = rootStore;

    polls = [Poll.fromJson(jsonPoll)];
  }

  setCurrentPoll(Poll poll) {
    currentPoll = poll;
    this.rootStore.notifyListeners();
  }
}
