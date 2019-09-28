class Answer {
  String questionId;
  String text;
  int rating;

  Answer(this.questionId, this.text, this.rating);

  toJson() {
    var map = {
      'question_id': questionId,
      'text': text,
      'rating': rating
    };

    return map;
  }
}