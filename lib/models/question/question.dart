class Question {
  String id;
  String title;
  String type;
  List<String> options;

  Question.fromJson(map) {
    id = map['_id'];
    title = map['title'];
    type = map['type'];
    options = [];

    var jsonOptions = map['options'];

    if (jsonOptions != null) {
      jsonOptions.forEach((jsonOption) {
        options.add(jsonOption);
      });
    }
  }
}
