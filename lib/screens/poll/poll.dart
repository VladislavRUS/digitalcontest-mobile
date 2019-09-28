import 'package:digitalcontest_mobile/components/button/button.dart';
import 'package:digitalcontest_mobile/components/questions/rating_question.dart';
import 'package:digitalcontest_mobile/components/questions/select_question.dart';
import 'package:digitalcontest_mobile/components/questions/text_question.dart';
import 'package:digitalcontest_mobile/constants/question_types/question_types.dart';
import 'package:digitalcontest_mobile/models/question/question.dart';
import 'package:digitalcontest_mobile/store/answers_store.dart';
import 'package:digitalcontest_mobile/store/polls_store.dart';
import 'package:digitalcontest_mobile/store/root_store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PollScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PollScreenState();
  }
}

class PollScreenState extends State<PollScreen> {
  static RootStore of(context) =>
      ScopedModel.of(context, rebuildOnChange: true);

  Widget buildPoll() {
    PollsStore pollsStore = of(context).pollsStore;

    return ListView.builder(
        itemCount: pollsStore.currentPoll.questions.length,
        itemBuilder: (context, index) {
          return buildQuestion(pollsStore.currentPoll.questions[index]);
        });
  }

  Widget buildQuestion(Question question) {
    AnswersStore answersStore = of(context).answersStore;

    if (question.type == QuestionTypes.RATING) {
      var selectedStar = answersStore.getSelectedStar(question);

      return RatingQuestion(question, selectedStarValue: selectedStar,
          onSelectStar: (rating) {
        answersStore.selectStar(question.id, rating);
      });
    } else if (question.type == QuestionTypes.SELECT) {
      var selectedOption = answersStore.getSelectedOption(question);

      return SelectQuestion(question, selectedOption: selectedOption,
          onOptionSelect: (option) {
        answersStore.selectOption(question.id, option);
      });
    } else {
      var text = answersStore.getText(question);

      return TextQuestion(question, text: text, onTextChange: (text) {
        answersStore.setText(question.id, text);
      });
    }
  }

  onFinish() async {
    RootStore rootStore = of(context);

    AnswersStore answersStore = rootStore.answersStore;
    await answersStore.submitAnswers();

    await showDialog(context: context, builder: (_) {
      return AlertDialog(title: Text('Спасибо за прохождение опроса!'));
    });

    Navigator.of(context).pop();
  }

  isLoading() {
    AnswersStore answersStore = of(context).answersStore;
    return answersStore.isLoading;
  }

  isButtonDisabled() {
    RootStore rootStore = of(context);
    List<Question> questions = rootStore.pollsStore.currentPoll.questions;
    AnswersStore answersStore = of(context).answersStore;
    var questionWithoutAnswer = questions.firstWhere((question) {
      var questionAnswer = answersStore.answers.firstWhere(
          (answer) => answer.questionId == question.id,
          orElse: () => null);

      return questionAnswer == null;
    }, orElse: () => null);

    return questionWithoutAnswer != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: buildPoll(),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Button('Завершить', onFinish,
                isLoading: isLoading(), isDisabled: isButtonDisabled()),
          )
        ],
      ),
    );
  }
}
