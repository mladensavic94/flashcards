import 'dart:math';

import 'package:flashcards/model/card_data.dart';

class CardFolder{

  int id;
  String title;
  String desc;
  List<CardData> cards;
  int score;
  int time;

  CardFolder(this.title,this.desc, this.cards, this.score, this.time) : id = Random().nextInt(10000);


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
}