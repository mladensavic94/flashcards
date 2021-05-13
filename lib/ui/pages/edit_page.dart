import 'package:flashcards/model/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/card_folder.dart';

class CreateFlashcardDrawer extends StatefulWidget {
  CardFolder _cardFolder;

  CreateFlashcardDrawer(this._cardFolder);

  @override
  _CreateFlashcardDrawerState createState() => _CreateFlashcardDrawerState();
}

class _CreateFlashcardDrawerState extends State<CreateFlashcardDrawer> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget._cardFolder.title;
    descController.text = widget._cardFolder.desc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editor"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(children: [
                  TextField(
                    decoration: InputDecoration(labelText: "Quiz name"),
                    controller: titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Quiz description"),
                    controller: descController,
                  )
                ]),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  itemCount: widget._cardFolder.cards.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Column(
                        children: [
                          TextField(
                            decoration:
                                InputDecoration(labelText: "Question 1"),
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: "Answer 1"),
                          )
                        ],
                      ),
                      trailing: Column(
                        children: [
                          Spacer(
                            flex: 2,
                          ),
                          (index + 1 == widget._cardFolder.cards.length)
                              ? IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => debugPrint("add"),
                                )
                              : IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () => debugPrint("remove"),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        widget._cardFolder.title = titleController.text;
                        widget._cardFolder.desc = descController.text;
                        Navigator.pop(context, widget._cardFolder);
                      },
                      child: Icon(Icons.save),
                      style: Constants.defaultButtonWithColor(Colors.green)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, widget._cardFolder);
                    },
                    child: Icon(Icons.cancel),
                    style: Constants.defaultButtonWithColor(Colors.red),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
