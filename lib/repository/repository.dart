import 'package:flashcards/model/card_data.dart';
import 'package:flashcards/model/card_folder.dart';

abstract class Repository{

  Future<void> save(CardFolder folder);
  Future<CardFolder> find(int id);
  Future<List<CardFolder>> findAll();
  Future<List<CardFolder>> remove(CardFolder folder);
}

class FakeRepository extends Repository{

  List<CardFolder> data = List.of([CardFolder("Flutter","sitna slova", [CardData("What lang is this app written?", "Dart"), CardData("What is this", "IDK")], 0, 0),
    CardFolder("Second","druga sitna slova", [CardData("What lang is this app written", "Dart"), CardData("What is this", "IDK2")], 0, 0)]);

  @override
  Future<CardFolder> find(int id) {
    return Future.value(data.first);
  }

  @override
  Future<List<CardFolder>> findAll() {
    return Future.value(data);
  }

  @override
  Future<void> save(CardFolder folder) {
    data.add(folder);
    return Future.value();
  }

  @override
  Future<List<CardFolder>> remove(CardFolder folder) {
    data.remove(folder);
    return Future.value(data);
  }

}