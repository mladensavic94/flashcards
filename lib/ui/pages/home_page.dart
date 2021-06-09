import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/quiz_cubit.dart';
import '../../bloc/quiz_state.dart';
import '../../model/constants.dart';
import '../../model/quiz.dart';
import '../widgets/action_card.dart';
import 'edit_page.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin{
  TextEditingController searchController = TextEditingController();
  static const Duration toggleDuration = Duration(milliseconds: 250);
  static const double maxSlide = 225;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: toggleDuration,
    );
  }

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
            blurRadius: 20,
            offset: Offset(5, 5),
          )
        ]),
        child: ActionCard(
          data: data,
        ),
      ),
    );
  }

  _search() {
    var searchWord = searchController.text;
    context.read<CardFolderCubit>().search(searchWord);
  }
}
