import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../bloc/quiz_cubit.dart';
import '../../model/quiz.dart';
import '../pages/edit_page.dart';
import '../pages/quiz_page.dart';
import '../widgets/icon_and_text.dart';

class ActionCard extends StatefulWidget {
  final Quiz data;

  const ActionCard({Key? key, required this.data}) : super(key: key);

  @override
  _ActionCardState createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard>
    with SingleTickerProviderStateMixin {
  static const Duration toggleDuration = Duration(milliseconds: 250);

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: toggleDuration,
      upperBound: 1,
      lowerBound: -1,
      value: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.2;
    double maxSlide = MediaQuery.of(context).size.width * 0.2;

    return Stack(
      children: [
        // edit card visible when swipe left
        Container(
          height: cardHeight,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: (MediaQuery.of(context).size.width * 0.04)),
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.edit),
                  onPressed: _startEdit,
                ),
              )),
        ),
        // delete card visible when swipe right
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: cardHeight,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: (MediaQuery.of(context).size.width * 0.04)),
                  child: IconButton(
                    iconSize: 30,
                    icon: Icon(Icons.delete),
                    onPressed: _delete,
                  ),
                )),
          ),
        ),
        GestureDetector(
          onDoubleTap: _startQuiz,
          onHorizontalDragUpdate: (details) => _onDragUpdate(details, maxSlide),
          onHorizontalDragEnd: _onDragEnd,
          behavior: HitTestBehavior.translucent,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Transform.translate(
                offset: Offset(maxSlide * (_animationController.value), 0),
                child: Stack(
                  children: [
                    Container(
                        height: cardHeight,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        child: Text(
                          widget.data.title,
                          style: Theme.of(context).textTheme.bodyText2,
                        )),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.1,
                        left: MediaQuery.of(context).size.width * 0.22,
                        child: IconAndText(
                          icon: Image(
                            width: 50,
                            image: AssetImage("assets/img/score.png"),
                          ),
                          text: Text(
                            "${widget.data.score}/${widget.data.cards.length}",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        )),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.1,
                        right: MediaQuery.of(context).size.width * 0.2,
                        child: IconAndText(
                          icon: Image(
                            width: 50,
                            image: AssetImage("assets/img/stopwatch.png"),
                          ),
                          text: Text(
                            "${widget.data.time} second(s)",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        )),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onDragUpdate(DragUpdateDetails details, double maxSlide) {
    double delta = details.primaryDelta! / maxSlide;
    _animationController.value += delta;
  }

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 365.0;

    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value.abs() < 0.5) {
      _animationController.animateTo(0);
    } else if (_animationController.value < -0.5) {
      _animationController.animateTo(-1);
    } else
      _animationController.animateTo(1);
  }

  void _startQuiz() {
    var result = Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage(widget.data.copyWithoutAnswers()),
        ));
    result.then((value) {
      setState(() {
        if (value != null) context.read<CardFolderCubit>().save(value);
        print(value.toString());
      });
    });
  }

  void _startEdit() {
    var result = Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditPage(widget.data.copy()),
        ));
    result.then((value) {
      setState(() {
        print(value.toString());
        if (value != null) context.read<CardFolderCubit>().save(value);
      });
    });
  }

  void _delete() {
    //TODO add confirmation dialog
    context.read<CardFolderCubit>().remove(widget.data);
  }
}
