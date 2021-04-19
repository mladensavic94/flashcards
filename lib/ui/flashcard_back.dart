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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.grey,
        child: SizedBox(
          height: 400,
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
                      onPressed: () => widget._answerCallback(1),
                      child: Icon(Icons.check),
                      style: Constants.defaultButtonWithColor(Colors.green),
                    ),
                    ElevatedButton(
                      onPressed: () => widget._answerCallback(0),
                      child: Icon(Icons.cancel_outlined),
                      style: Constants.defaultButtonWithColor(Colors.red),
                    )
                  ],
                )
              ],
            ),
          ),
          key: ValueKey(widget._answer),
        ),
      ),
    );
  }
}
