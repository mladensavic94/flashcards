import 'package:flashcards/bloc/card_folder_cubit.dart';
import 'package:flashcards/bloc/card_folder_state.dart';
import 'package:flashcards/model/card_folder.dart';
import 'package:flashcards/model/constants.dart';
import 'package:flashcards/ui/expansioncard.dart';
import 'package:flashcards/ui/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashcardHomePage extends StatefulWidget {
  @override
  _FlashcardHomePageState createState() => _FlashcardHomePageState();
}

class _FlashcardHomePageState extends State<FlashcardHomePage> {
  @override
  Widget build(BuildContext context) {
    context.read<CardFolderCubit>().getAllFolders();
    return Scaffold(
      appBar: AppBar(title: Text("FlashCards")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint("clicked!"),
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<CardFolderCubit, CardFolderState>(
        builder: (context, state) {
          switch (state.status) {
            case CardFolderStatus.loaded:
              return Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) => _buildDrawer(state.data[index]),
                ),
              );
            case CardFolderStatus.empty:
              return Center(child: Text("Bracela nema nicega, klikni na + i dodaj!", style: Constants.normalText(),),);
            default:
              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.white),
              );
          }
        },
      ),
    );
  }

  Widget _buildDrawer(CardFolder data) {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: ExpansionCard(
        title: Container(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(
                flex: 1,
              ),
              Text(
                data.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                data.desc,
                style: TextStyle(fontSize: 14),

              ),
              Text(
                "Score: ${data.score == 0 ? "N/A" : data.score.toString() + "/" + data.cards.length.toString()}",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Best time: ${data.time == 0 ? "N/A" : data.time.toString() + "s"}",
                style: TextStyle(fontSize: 14),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizPage(data, _scoreCallback)));
                },
                child: Icon(Icons.play_circle_fill),
                style: Constants.defaultButtonWithColor(Colors.blue),
              ),
              ElevatedButton(
                onPressed: () => debugPrint("second"),
                child: Icon(Icons.edit),
                style: Constants.defaultButtonWithColor(Colors.green),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<CardFolderCubit>().remove(data);
                },
                child: Icon(Icons.delete),
                style: Constants.defaultButtonWithColor(Colors.red),
              )
            ],
          )
        ],
        backgroundColor: Color.fromRGBO(170, 170, 170, 5),
      ),
    );
  }

  void _scoreCallback(int score) {
    debugPrint("Score is $score");
  }
}
