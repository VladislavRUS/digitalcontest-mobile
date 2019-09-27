class Option {
  String id;
  String text;

  Option.fromJson(map) {
    id = map['id'];
    text = map['text'];
  }
}