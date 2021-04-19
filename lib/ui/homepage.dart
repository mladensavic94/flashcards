import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_folder_cubit.dart';
import '../bloc/card_folder_state.dart';
import '../model/card_folder.dart';
import '../model/constants.dart';
import '../ui/expansion_card.dart';
import '../ui/quiz_page.dart';
import '../ui/background_painter.dart';
import '../ui/edit_page.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    context.read<CardFolderCubit>().getAllFolders();
    final appBar = AppBar(title: Text("FlashCards"));
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createFlashcardDrawer(CardFolder("", "", [], 0, 0)),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.multiline_chart), label: "Statistics"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
      ], onTap: (value) => debugPrint("jedi govna bas sad! $value"),),
      body: Stack(
        children: [
          Container(
            color: Color.fromRGBO(226, 235, 235, 1),
          ),
          CustomPaint(
            painter: BackgroundPainter(Color.fromRGBO(49, 73, 60, 0.3)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.21,
            ),
          ),
          CustomPaint(
            painter: BackgroundPainter(Color.fromRGBO(179, 239, 178, 1)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          _buildBody()
        ],
      ),
    );
  }

  BlocBuilder<CardFolderCubit, CardFolderState> _buildBody() {
    return BlocBuilder<CardFolderCubit, CardFolderState>(
      builder: (context, state) {
        switch (state.status) {
          case CardFolderStatus.loaded:
            return Column(
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height) * 0.20,
                  child: Center(child: Text("What are we learning today?")),
                ),
                Container(
                  height: (MediaQuery.of(context).size.height) * 0.6,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                    child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) =>
                          _buildDrawer(state.data[index]),
                    ),
                  ),
                ),
              ],
            );
          case CardFolderStatus.empty:
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

  void _createFlashcardDrawer(CardFolder cardFolder) {
    var result = Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateFlashcardDrawer(cardFolder),
        ));
    result.then((value) {
      setState(() {
        if (value != null) context.read<CardFolderCubit>().save(value);
      });
    });
  }

  Widget _buildDrawer(CardFolder data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
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
                        if (value is CardFolder) data = value;
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
        ),
      ),
    );
  }
}
