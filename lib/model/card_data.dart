import 'package:flutter/material.dart';

class CardInfo {
  String question;
  String answer;
  QuestionState state;

  CardInfo(this.question, this.answer, this.state);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardInfo &&
          runtimeType == other.runtimeType &&
          question == other.question &&
          answer == other.answer;

  @override
  String toString() {
    return 'CardData{question: $question, answer: $answer, state: $state}';
  }

  @override
  int get hashCode => question.hashCode ^ answer.hashCode;
}

enum QuestionState { CORRECT, WRONG, UNANSWERED }

extension QuestionStateExtension on QuestionState {
  Color get color {
    switch (this) {
      case QuestionState.CORRECT:
        return Colors.green;
      case QuestionState.WRONG:
        return Colors.red;
      case QuestionState.UNANSWERED:
        return Colors.grey;
    }
  }

  IconData get iconData {
    switch (this) {
      case QuestionState.CORRECT:
        return Icons.mood;
      case QuestionState.WRONG:
        return Icons.mood_bad;
      case QuestionState.UNANSWERED:
        return Icons.pending_outlined;
    }
  }

  int get value {
    switch (this) {
      case QuestionState.CORRECT:
        return 1;
      case QuestionState.WRONG:
        return 0;
      case QuestionState.UNANSWERED:
        return 0;
    }
  }
}
