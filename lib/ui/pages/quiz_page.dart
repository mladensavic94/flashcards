import 'package:flutter/material.dart';

import '../../model/card_data.dart';
import '../../model/quiz.dart';
import '../../model/constants.dart';
import '../widgets/flashcard.dart';

class QuizPage extends StatefulWidget {
  final Quiz data;

  QuizPage(this.data);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int cardIndex = 0;
  int score = 0;
  int time = 0;
  Stream<int> timer = Stream.periodic(Duration(seconds: 1), (val) => val + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.data.title)),
      body: Stack(
        children: [
          ...Constants.backgroundPainterSetup(context),
          _buildMainBody()
        ],
      ),
    );
  }

  Widget _buildMainBody() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildScoreWidget(context),
                _buildTimerWidget(context)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              switchInCurve: Curves.linear,
              child: Flashcard(
                widget.data.cards[cardIndex],
                updateScore,
                key: ValueKey(cardIndex),
              ),
            ),
          ),
          _buildQuestionsWidget(context),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  Container _buildQuestionsWidget(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: widget.data.cards.map((e) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(
                    color: e.state.color,
                    shape: BoxShape.circle),
                child: Center(
                  child: IconButton(
                    icon: Icon(e.state.iconData),
                    onPressed: () {
                      setState(() {
                        cardIndex = widget.data.cards.indexOf(e);
                      });
                    },
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }

  Column _buildScoreWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Center(
            child: Text("$score",
                style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: Theme.of(context).textTheme.bodyText1!.color)),
          ),
        ),
        Text("SCORE", style: Theme.of(context).textTheme.bodyText1)
      ],
    );
  }

  Column _buildTimerWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Center(
            child: StreamBuilder(
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                time = snapshot.data!;
                return FittedBox(
                  child: Text(
                    "${snapshot.data}",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                );
              },
              initialData: 0,
              stream: timer,
            ),
          ),
        ),
        Text("TIME", style: Theme.of(context).textTheme.bodyText1)
      ],
    );
  }

  AlertDialog _endDialog(BuildContext context) {
    return AlertDialog(
      title: Text("All done!",style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 26)),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Score: ${widget.data.score} of ${widget.data.cards.length}",
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              "Time: ${Constants.wrapZero(widget.data.time)} sec",
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text("Exit"),
          style: Constants.defaultButtonWithColor(Theme.of(context).primaryColor),)
      ],
    actionsPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2),
    );
  }

  void updateScore(QuestionState state) {
    setState(() {
      widget.data.cards[cardIndex].state = state;
      score += state.value;
      var nextIndex = findNextIndex(widget.data.cards);
      if (nextIndex >= 0)
        cardIndex = nextIndex;
      else {
        widget.data.score = score;
        widget.data.time = time;
        timer = Stream.empty();
        var result = showDialog(
          context: context,
          builder: (context) => _endDialog(context),
        );
        result.then((value) => {
          if(value) Navigator.pop(context, widget.data)
        });
      }
    });
  }

  int findNextIndex(List<CardInfo> cards) {
    for (int i = cardIndex + 1; i <= cards.length; i++) {
      if(i == cards.length)
        i = 0;
      if(cards[i].state == QuestionState.UNANSWERED)
        return i;
      if(i == cardIndex) break;
    }
    return -1;
  }
}
