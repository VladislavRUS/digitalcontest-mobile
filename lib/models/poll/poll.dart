import 'package:digitalcontest_mobile/models/geo/geo.dart';
import 'package:digitalcontest_mobile/models/question/question.dart';

class Poll {
  String id;
  String title;
  String text;
  String image;
  String video;
  Geo geo;
  List<Question> questions;

  Poll.fromJson(map) {
    id = map['id'];
    title = map['title'];
    text = map['text'];
    image = map['image'];
    video = map['video'];
    geo = Geo.fromJson(map['geo']);
    questions = [];

    var jsonQuestions = map['questions'];
    jsonQuestions.forEach((jsonQuestion) {
      questions.add(Question.fromJson(jsonQuestion));
    });
  }
}
