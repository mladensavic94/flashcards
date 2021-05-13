import 'package:flashcards/model/constants.dart';
import 'package:flutter/material.dart';

class FlashCardFront extends StatefulWidget {
  final String _question;

  FlashCardFront(this._question);

  @override
  _FlashCardFrontState createState() => _FlashCardFrontState();
}

class _FlashCardFrontState extends State<FlashCardFront> {
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
      child: Center(
        child: Text(
          widget._question,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
