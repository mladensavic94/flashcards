import 'package:flashcards/model/card_data.dart';

class CardFolder{

  final String title;
  final String desc;
  final List<CardData> cards;
  final int score;
  final int time;

  CardFolder(this.title,this.desc, this.cards, this.score, this.time);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardFolder &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          desc == other.desc &&
          cards == other.cards &&
          score == other.score &&
          time == other.time;

  @override
  int get hashCode =>
      title.hashCode ^
      desc.hashCode ^
      cards.hashCode ^
      score.hashCode ^
      time.hashCode;
}