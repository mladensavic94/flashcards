import 'package:flashcards/model/card_data.dart';
import 'package:flashcards/model/card_folder.dart';
import 'package:flutter/material.dart';

abstract class Repository{

  Future<void> save(CardFolder folder);
  Future<CardFolder> find(int id);
  Future<List<CardFolder>> findAll();
  Future<List<CardFolder>> remove(CardFolder folder);
}

class FakeRepository extends Repository{

  List<CardData> longQuiz = List.generate(10, (index) => CardData("$index Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.?", "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ", -1));
  List<CardFolder> data = List.of([CardFolder("Flutter","sitna slova", [], 0, 0),
    CardFolder("Second","druga sitna slova", [CardData("What lang is this app written", "Dart",-1), CardData("What is this", "IDK2",-1)], 0, 0)]);

  @override
  Future<CardFolder> find(int id) {
    return Future.value(data.first);
  }

  @override
  Future<List<CardFolder>> findAll() {
    data[0].cards = longQuiz;
    return Future.value(data);
  }

  @override
  Future<void> save(CardFolder folder) {
    if(data.any((element) => element.id == folder.id)){
      var index = data.indexOf(folder);
      data[index] = folder;
    }else{
      data.add(folder);
    }
    return Future.value();
  }

  @override
  Future<List<CardFolder>> remove(CardFolder folder) {
    data.remove(folder);
    return Future.value(data);
  }

}