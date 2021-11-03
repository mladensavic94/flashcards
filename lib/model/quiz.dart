import 'dart:math';

import '../model/card_data.dart';

class Quiz extends Comparable<Quiz> {
  int id;
  String title;
  String desc;
  List<CardInfo> cards;
  int score;
  int time;
  bool isFavourite = false;

  Quiz(this.title, this.desc, this.cards, this.score, this.time)
      : id = Random().nextInt(10000);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quiz && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CardFolder{id: $id, title: $title, desc: $desc, cards: $cards, score: $score, time: $time}';
  }

  @override
  int compareTo(Quiz other) {
    if (this.isFavourite && !other.isFavourite)
      return -1;
    else if (this.isFavourite == other.isFavourite) {
      return this.title.compareTo(other.title);
    } else {
      return 1;
    }
  }

  Quiz copy() {
    var copy = Quiz(this.title, this.desc, this.cards, this.score, this.time);
    copy.id = this.id;
    copy.isFavourite = this.isFavourite;
    copy.cards = copy.cards.map((card) {
      var newCard = CardInfo(card.question, card.answer, card.state);
      return newCard;
    }).toList();
    return copy;
  }

  Quiz copyWithoutAnswers() {
    var copy = Quiz(this.title, this.desc, this.cards, this.score, this.time);
    copy.id = this.id;
    copy.isFavourite = this.isFavourite;
    copy.cards = copy.cards.map((card) {
      var newCard = CardInfo(card.question, card.answer, QuestionState.UNANSWERED);
      return newCard;
    }).toList();
    return copy;
  }
}
