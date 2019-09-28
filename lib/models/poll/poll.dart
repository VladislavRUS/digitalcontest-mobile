import 'package:digitalcontest_mobile/models/geo/geo.dart';
import 'package:digitalcontest_mobile/models/question/question.dart';

class Poll {
  String id;
  String title;
  String text;
  String image;
  String video;
  String legalType;
  int creationDate;
  Geo geo;
  List<Question> questions;

  Poll.fromJson(map) {
    id = map['_id'];
    title = map['title'];
    text = map['text'];
    image = map['image'];
    video = map['video'];
    legalType = map['legalType'];
    creationDate = int.parse(map['date_created']);
    geo = map['geo'] != null ? Geo.fromJson(map['geo']) : null;
    questions = [];

    var jsonQuestions = map['questions'];
    jsonQuestions.forEach((jsonQuestion) {
      questions.add(Question.fromJson(jsonQuestion));
    });
  }
}
