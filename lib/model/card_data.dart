class CardData{
  String question;
  String answer;

  CardData(this.question, this.answer);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardData &&
          runtimeType == other.runtimeType &&
          question == other.question &&
          answer == other.answer;

  @override
  String toString() {
    return 'CardData{question: $question, answer: $answer}';
  }

  @override
  int get hashCode => question.hashCode ^ answer.hashCode;
}