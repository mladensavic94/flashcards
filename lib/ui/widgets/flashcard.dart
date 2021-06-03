import 'dart:math';

import 'package:flashcards/model/card_data.dart';
import 'flashcard_back.dart';
import 'flashcard_front.dart';
import 'package:flutter/material.dart';

class Flashcard extends StatefulWidget {
  final CardInfo _cardData;
  final Function _answerCallback;

  Flashcard(this._cardData, this._answerCallback, {key}) :super(key: key);

  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard>
    with SingleTickerProviderStateMixin {

  late Widget _front;
  late Widget _back;
  bool frontSide = true;

  @override
  void initState() {
    super.initState();
    _front = FlashCardFront(widget._cardData.question);
    _back = FlashCardBack(widget._cardData.answer, widget._answerCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: EdgeInsets.all(0),
        child: GestureDetector(
          onTap: () {
            setState(() => frontSide = !frontSide);
          },
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 750),
            child: frontSide ? _front : _back,
            transitionBuilder: (child, animation) =>
                _transitionBuilder(child, animation),
            layoutBuilder: (currentChild, previousChildren) =>
                _layoutBuilder(previousChildren, currentChild),
            // switchInCurve: Curves.easeInBack,
            // switchOutCurve: Curves.easeInBack.flipped,
          ),
        ),
      )),
    );
  }

  Stack _layoutBuilder(List<Widget> previousChildren, Widget? currentChild) {
    List<Widget> children = List.from(previousChildren);
    if (currentChild != null) children = children..insert(0, currentChild);
    return Stack(
      children: children,
      alignment: Alignment.center,
    );
  }

  Widget _transitionBuilder(Widget child, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: child,
      builder: (context, widget2) {
        final isUnder = frontSide ==
            (widget2.runtimeType.toString() == "FlashCardBack");
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value),
          child: widget2,
          alignment: Alignment.center,
        );
      },
    );
  }
}
