import 'package:digitalcontest_mobile/models/answer/answer.dart';
import 'package:digitalcontest_mobile/models/question/question.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:requests/requests.dart';
import 'package:scoped_model/scoped_model.dart';

class AnswersStore extends Model {
  RootStore rootStore;
  List<Answer> answers = [];
  bool isLoading = false;

  AnswersStore(this.rootStore);

  selectOption(String questionId, String option) {
    var existingAnswer = getExistingAnswer(questionId);

    if (existingAnswer == null) {
      var answer = Answer(questionId, option, 0);
      answers.add(answer);
    } else {
      existingAnswer.text = option;
    }

    rootStore.notifyListeners();
  }

  selectStar(String questionId, int rating) {
    var existingAnswer = getExistingAnswer(questionId);

    if (existingAnswer == null) {
      var answer = Answer(questionId, '', rating);
      answers.add(answer);
    } else {
      existingAnswer.rating = rating;
    }

    rootStore.notifyListeners();
  }

  setText(String questionId, String text) {
    var existingAnswer = getExistingAnswer(questionId);

    if (existingAnswer == null) {
      var answer = Answer(questionId, text, 0);
      answers.add(answer);
    } else {
      existingAnswer.text = text;
    }

    rootStore.notifyListeners();
  }

  Answer getExistingAnswer(questionId) {
    return answers.firstWhere((answer) => answer.questionId == questionId,
        orElse: () => null);
  }

  getSelectedOption(Question question) {
    var existingAnswer = getExistingAnswer(question.id);
    if (existingAnswer != null) {
      return existingAnswer.text;
    }

    return '';
  }

  getSelectedStar(Question question) {
    var existingAnswer = getExistingAnswer(question.id);
    if (existingAnswer != null) {
      return existingAnswer.rating;
    }

    return 0;
  }

  getText(Question question) {
    var existingAnswer = getExistingAnswer(question.id);
    if (existingAnswer != null) {
      return existingAnswer.text;
    }

    return '';
  }

  submitAnswers() async {
    isLoading = true;
    rootStore.notifyListeners();

    var url = rootStore.apiHost + '/api/mobile/v1/answer/submit';

    var answersArr = [];

    answers.forEach((answer) {
      answersArr.add({
        'question_id': answer.questionId,
        'text': answer.text,
        'rating': answer.rating
      });
    });

    var body = {
      'poll_id': rootStore.pollsStore.currentPoll.id,
      'answers': answers
    };

    var headers = {
      'x-access-token': rootStore.getAccessToken().toString(),
      'Content-Type': 'application/json'
    };

    try {
      await Requests.post(url, body: body, headers: headers);
      rootStore.pollsStore.fetchFinishedPolls();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      rootStore.notifyListeners();
    }
  }

  clear() {
    answers = [];
    isLoading = false;
    rootStore.notifyListeners();
  }
}
