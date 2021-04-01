import 'package:flashcards/model/card_folder.dart';
import 'package:flashcards/model/constants.dart';
import 'package:flashcards/ui/flashcard.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final CardFolder data;
  final Function scoreCallbackHandler;

  QuizPage(this.data, this.scoreCallbackHandler);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int cardIndex = 0;
  int score = 0;
  int time = 0;
  Stream<int> timer = Stream.periodic(Duration(seconds: 1), (val) => val+1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.data.title)),
      body: Padding(
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Question no: ${cardIndex + 1}/${widget.data.cards.length}",
              style: Constants.normalText(),
            ),
            StreamBuilder(
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                time = snapshot.data!;
                return Text(
                  "Time: ${snapshot.data}s (best time: ${Constants.wrapZero(widget.data.time)})",
                  style: Constants.normalText(),
                );
              },
              initialData: 0,
              stream: timer,
            ),
            Text(
              "Score: $score (best score ${Constants.wrapZero(widget.data.score)})",
              style: Constants.normalText(),
            ),
            Spacer(
              flex: 1,
            ),
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 10)
                  setState(() {
                    cardIndex = 1;
                  });
                else if (details.delta.dx < -10) {
                  setState(() {
                    cardIndex = 0;
                  });
                }
              },
              child: Flashcard(
                widget.data.cards[cardIndex],
                updateScore,
                key: ValueKey(cardIndex),
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  void updateScore(int scoreVal) {
    setState(() {
      score += scoreVal;
      if (cardIndex + 1 < widget.data.cards.length) cardIndex += 1;
      if (cardIndex == widget.data.cards.length - 1) {
      }
    });
  }
}
