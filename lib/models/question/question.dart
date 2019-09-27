import 'package:digitalcontest_mobile/models/option/option.dart';

class Question {
  String id;
  String title;
  String type;
  List<Option> options;

  Question.fromJson(map) {
    id = map['id'];
    title = map['title'];
    type = map['type'];
    options = [];

    var jsonOptions = map['options'];
    jsonOptions.forEach((jsonOption) {
      options.add(Option.fromJson(jsonOption));
    });
  }
}