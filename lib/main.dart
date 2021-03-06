import 'package:flashcards/bloc/quiz_cubit.dart';
import 'package:flashcards/repository/repository.dart';
import 'package:flashcards/ui/pages/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(FlashCards());
}

class FlashCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlashCards',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromRGBO(64, 99, 65, 1),
          scaffoldBackgroundColor: Color.fromRGBO(226, 235, 235, 1),
          textTheme: TextTheme(
            bodyText1: TextStyle(
                fontSize: 20,
                fontFamily: "RobotoMono",
                color: Color.fromRGBO(0, 26, 35, 1),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal),
            bodyText2: TextStyle(
                fontSize: 20,
                fontFamily: "RobotoMono",
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(0, 26, 35, 1),
                fontWeight: FontWeight.bold),
            headline6: TextStyle(
                fontSize: 16,
                fontFamily: "RobotoMono",
                color: Color.fromRGBO(0, 26, 35, 1),
                fontWeight: FontWeight.normal),
            headline5: TextStyle(
                fontSize: 25,
                fontFamily: "RobotoMono",
                color: Color.fromRGBO(0, 26, 35, 1),
                fontWeight: FontWeight.normal),
          )),
      home: BlocProvider(
          create: (context) => CardFolderCubit(FakeRepository()),
          child: PageWrapper()),
    );
  }
}
