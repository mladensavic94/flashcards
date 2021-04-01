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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.grey,
        child: SizedBox(
          height: 400,
          child: Center(
            child: Text(widget._question, style: TextStyle(fontSize: 25, ), textAlign: TextAlign.center,),
          ),
          key: ValueKey(widget._question),
        ),
      ),
    );
  }
}
 