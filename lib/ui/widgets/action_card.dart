import 'package:flashcards/model/quiz.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {

  final Quiz data;

  const ActionCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.1;
    return Stack(
      children: [
        Container(
          height: cardHeight,
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
        ),
        Container(
          height: cardHeight,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
          child: ListTile(title: Text(data.title)))
      ],
    );
  }
}
