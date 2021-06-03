import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/quiz_cubit.dart';
import '../../bloc/quiz_state.dart';
import '../../model/card_data.dart';
import '../../model/constants.dart';
import '../../model/quiz.dart';
import '../widgets/expansion_card.dart';
import 'edit_page.dart';
import 'quiz_page.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<CardFolderCubit>().getAllFolders();
    return Stack(
      children: [...Constants.backgroundPainterSetup(context), _buildBody()],
    );
  }

  BlocBuilder<CardFolderCubit, QuizState> _buildBody() {
    return BlocBuilder<CardFolderCubit, QuizState>(
      builder: (context, state) {
        switch (state.status) {
          case QuizStatus.loaded:
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height) * 0.17,
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("What are we learning today?"),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: (MediaQuery.of(context).size.height) * 0.05,
                          width: (MediaQuery.of(context).size.width) * 0.80,
                          child: TextField(
                            onChanged: (_) => _search(),
                            controller: searchController,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                hintStyle:
                                    Theme.of(context).textTheme.headline6,
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () => _search(),
                                ),
                                hintText: "Search...",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50))),
                          ),
                        )
                      ],
                    )),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          children:
                              state.data.map((e) => _buildDrawer(e)).toList()),
                    ),
                  ),
                ],
              ),
            );
          case QuizStatus.empty:
            return Center(
              child: Text(
                "Create first quiz by clicking + below!",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
          default:
            return Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            );
        }
      },
    );
  }

  void _createFlashcardDrawer(Quiz cardFolder) {
    var result = Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditPage(cardFolder),
        ));
    result.then((value) {
      setState(() {
        if (value != null) context.read<CardFolderCubit>().save(value);
      });
    });
  }

  Widget _buildDrawer(Quiz data) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10.0, left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(5, 5),
          )
        ]),
        child: ExpansionCard(
          title: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(
                  flex: 1,
                ),
                Text(
                  data.title,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  data.desc,
                  style: Theme.of(context).textTheme.headline6,
                ),
                (data.time > 0)
                    ? Text(
                        "${data.score} correct (out of ${data.cards.length}) in ${data.time} secs",
                        style: Theme.of(context).textTheme.headline6,
                      )
                    : Container(),
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
                    var result = Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizPage(data)));
                    result.then((value) {
                      setState(() {
                        if (value is Quiz) {
                          data = value;
                          data.cards.forEach((e) {
                            e.state = QuestionState.UNANSWERED;
                          });
                        }
                      });
                    });
                  },
                  child: Icon(Icons.play_circle_fill),
                  style: Constants.defaultButtonWithColor(
                      Theme.of(context).primaryColor),
                ),
                ElevatedButton(
                  onPressed: () => _createFlashcardDrawer(data),
                  child: Icon(Icons.edit),
                  style: Constants.defaultButtonWithColor(
                      Theme.of(context).primaryColor),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CardFolderCubit>().remove(data);
                  },
                  child: Icon(Icons.delete),
                  style: Constants.defaultButtonWithColor(
                      Theme.of(context).primaryColor),
                )
              ],
            )
          ],
          backgroundColor: Colors.white,
          trailing: IconButton(
            icon: Icon(data.isFavourite ? Icons.star : Icons.star_border),
            onPressed: () {
              setState(() {
                data.isFavourite = !data.isFavourite;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "${data.title} ${data.isFavourite ? "added to" : "removed from"} favourites",
                      textAlign: TextAlign.center,
                    ),
                    duration: const Duration(milliseconds: 1000),
                    // width: MediaQuery.of(context).size.width * 0.6,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )));
              });
            },
          ),
        ),
      ),
    );
  }

  _search() {
    var searchWord = searchController.text;
    context.read<CardFolderCubit>().search(searchWord);
  }
}
