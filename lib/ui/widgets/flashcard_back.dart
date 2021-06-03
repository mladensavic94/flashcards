import 'package:flashcards/model/card_data.dart';
import 'package:flashcards/model/constants.dart';
import 'package:flutter/material.dart';

class FlashCardBack extends StatefulWidget {
  final String _answer;
  final Function _answerCallback;

  FlashCardBack(this._answer, this._answerCallback);

  @override
  _FlashCardBackState createState() => _FlashCardBackState();
}

class _FlashCardBackState extends State<FlashCardBack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(5, 5),
            )
          ]),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 2,
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(widget._answer, style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.center)),
            // Center(child: ),
            Spacer(
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => widget._answerCallback(QuestionState.CORRECT),
                  child: Icon(Icons.check),
                  style: Constants.defaultButtonWithColor(Colors.green),
                ),
                ElevatedButton(
                  onPressed: () => widget._answerCallback(QuestionState.WRONG),
                  child: Icon(Icons.cancel_outlined),
                  style: Constants.defaultButtonWithColor(Colors.red),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
