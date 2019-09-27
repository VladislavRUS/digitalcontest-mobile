import 'package:digitalcontest_mobile/models/post/post.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:scoped_model/scoped_model.dart';

class PostsStore extends Model {
  RootStore rootStore;
  List<Post> posts = [];

  PostsStore(RootStore rootStore) {
    this.rootStore = rootStore;
    posts = [
      Post(
          'Что сильнее всего выросло за 10 лет: акции, золото, вклады или валюта',
          'assets/posts/10year.jpg',
          '26 сент.',
          94,
          891,
          14),
      Post(
          'Сколько бы вы заработали, если бы вложили 1000 долларов в эти акции 10 лет назад',
          'assets/posts/get-yourself.gif',
          '27 сент.',
          191,
          768,
          31),
      Post('6 американских компаний, которые стабильно платят дивиденды',
          'assets/posts/aristocrats.png', '28 сент.', 136, 560, 20),
    ];
  }
}
