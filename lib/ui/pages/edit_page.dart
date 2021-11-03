import 'package:flashcards/model/card_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../model/quiz.dart';

class EditPage extends StatefulWidget {
  final Quiz _cardFolder;

  EditPage(this._cardFolder);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editor"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  widget._cardFolder.cards
                      .add(CardInfo("", "", QuestionState.UNANSWERED));
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Navigator.pop(context, widget._cardFolder);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: [
                TextField(
                  controller: TextEditingController(text: widget._cardFolder.title),
                  decoration: InputDecoration(labelText: "Quiz name:"),
                ),
                TextField(
                  controller: TextEditingController(text: widget._cardFolder.desc),
                  decoration: InputDecoration(labelText: "Quiz description:"),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    itemCount: widget._cardFolder.cards.length,
                    itemBuilder: (context, index) => _buildQABlock(context, index),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildQABlock(BuildContext context, int index) {
    return Column(
      children: [
        TextField(
          controller: TextEditingController(text: widget._cardFolder.cards[index].question),
          decoration: InputDecoration(labelText: "Question ${index + 1}:"),
          onChanged: (value) => widget._cardFolder.cards[index].question = value,
        ),
        TextField(
          controller: TextEditingController(text: widget._cardFolder.cards[index].answer),
          decoration: InputDecoration(labelText: "Answer ${index + 1}:"),
          onChanged: (value) => widget._cardFolder.cards[index].answer = value,
        )
      ],
    );
  }
}
