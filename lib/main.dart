import 'package:flashcards/bloc/card_folder_cubit.dart';
import 'package:flashcards/repository/repository.dart';
import 'package:flashcards/ui/flashcard_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlashCards',
     debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) => CardFolderCubit(FakeRepository()),
          child: FlashcardHomePage()),
    );
  }
}

