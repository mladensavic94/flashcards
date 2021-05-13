import 'dart:math';

import 'package:flashcards/model/card_data.dart';

class CardFolder extends Comparable<CardFolder> {
  int id;
  String title;
  String desc;
  List<CardData> cards;
  int score;
  int time;
  bool isFavourite = false;

  CardFolder(this.title, this.desc, this.cards, this.score, this.time)
      : id = Random().nextInt(10000);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardFolder && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CardFolder{id: $id, title: $title, desc: $desc, cards: $cards, score: $score, time: $time}';
  }

  @override
  int compareTo(CardFolder other) {
    if (this.isFavourite && !other.isFavourite)
      return -1;
    else if (this.isFavourite == other.isFavourite) {
      return this.title.compareTo(other.title);
    } else {
      return 1;
    }
  }
}
