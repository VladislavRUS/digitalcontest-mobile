import 'package:digitalcontest_mobile/constants/topics/topics.dart';
import 'package:digitalcontest_mobile/models/topic/topic.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:scoped_model/scoped_model.dart';

class TopicsStore extends Model {
  RootStore rootStore;
  List<Topic> topics = [];
  Topic currentTopic;

  TopicsStore(RootStore rootStore) {
    this.rootStore = rootStore;

    topics = [
      Topic(Topics.INVEST, 'Вложить'),
      Topic(Topics.LAW, 'Права'),
      Topic(Topics.SAVE, 'Сбережения'),
      Topic(Topics.TRAVEL, 'Путешествия'),
      Topic(Topics.CITY, 'Город'),
      Topic(Topics.CREDITS, 'Кредиты'),
    ];

    currentTopic = topics.first;
  }

  setCurrentTopic(topic) {
    this.currentTopic = topic;
    this.rootStore.notifyListeners();
  }
}