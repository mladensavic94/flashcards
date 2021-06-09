import 'dart:core';

import 'package:flashcards/model/card_data.dart';
import 'package:flashcards/model/quiz.dart';

abstract class Repository{

  Future<void> save(Quiz folder);
  Future<Quiz> find(int id);
  Future<List<Quiz>> findAll();
  Future<List<Quiz>> search(String search);
  Future<List<Quiz>> remove(Quiz folder);
}

class FakeRepository extends Repository{

  List<CardInfo> longQuiz = List.generate(10, (index) => CardInfo("$index Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.?", "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ", QuestionState.UNANSWERED));
  List<Quiz> data = List.of([Quiz("Flutter","sitna slova", [], 0, 0),
    Quiz("Second","druga sitna slova", [CardInfo("What lang is this app written", "Dart", QuestionState.UNANSWERED), CardInfo("What is this", "IDK2",QuestionState.UNANSWERED)], 0, 0),
    // Quiz("Second","druga sitna slova", [CardInfo("What lang is this app written", "Dart", QuestionState.UNANSWERED), CardInfo("What is this", "IDK2",QuestionState.UNANSWERED)], 0, 0),
    // Quiz("Second","druga sitna slova", [CardInfo("What lang is this app written", "Dart", QuestionState.UNANSWERED), CardInfo("What is this", "IDK2",QuestionState.UNANSWERED)], 0, 0),
    // Quiz("Second","druga sitna slova", [CardInfo("What lang is this app written", "Dart", QuestionState.UNANSWERED), CardInfo("What is this", "IDK2",QuestionState.UNANSWERED)], 0, 0),
    // Quiz("Second","druga sitna slova", [CardInfo("What lang is this app written", "Dart", QuestionState.UNANSWERED), CardInfo("What is this", "IDK2",QuestionState.UNANSWERED)], 0, 0),
    // Quiz("Second","druga sitna slova", [CardInfo("What lang is this app written", "Dart", QuestionState.UNANSWERED), CardInfo("What is this", "IDK2",QuestionState.UNANSWERED)], 0, 0),
    // Quiz("Second","druga sitna slova", [CardInfo("What lang is this app written", "Dart", QuestionState.UNANSWERED), CardInfo("What is this", "IDK2",QuestionState.UNANSWERED)], 0, 0),
    // Quiz("Second","druga sitna slova", [CardInfo("What lang is this app written", "Dart", QuestionState.UNANSWERED), CardInfo("What is this", "IDK2",QuestionState.UNANSWERED)], 0, 0),
    // Quiz("Second","druga sitna slova", [CardInfo("What lang is this app written", "Dart", QuestionState.UNANSWERED), CardInfo("What is this", "IDK2",QuestionState.UNANSWERED)], 0, 0),
    // Quiz("Second","druga sitna slova", [CardInfo("What lang is this app written", "Dart", QuestionState.UNANSWERED), CardInfo("What is this", "IDK2",QuestionState.UNANSWERED)], 0, 0),
  ]);

  @override
  Future<Quiz> find(int id) {
    return Future.value(data.first);
  }

  @override
  Future<List<Quiz>> findAll() {
    data[0].cards = longQuiz;
    data.sort();
    return Future.value(data);
  }

  @override
  Future<void> save(Quiz folder) {
    if(data.any((element) => element.id == folder.id)){
      var index = data.indexOf(folder);
      data[index] = folder;
    }else{
      data.add(folder);
    }
    return Future.value();
  }

  @override
  Future<List<Quiz>> remove(Quiz folder) {
    data.remove(folder);
    return Future.value(data);
  }

  @override
  Future<List<Quiz>> search(String search) {
    var result = data.where((element) => element.title.toLowerCase().startsWith(search.toLowerCase())).toList();
    result.sort();
    return Future.value(result);
  }
}