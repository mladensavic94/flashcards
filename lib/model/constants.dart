import 'package:flashcards/ui/background_painter.dart';
import 'package:flutter/material.dart';

class Constants{

  static String wrapZero(int value){
    if(value == 0)
      return "N/A";
    return value.toString();
  }

  static ButtonStyle defaultButtonWithColor(Color color){
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
                (states) => color),
        minimumSize: MaterialStateProperty.resolveWith(
                (states) => Size(90, 45)));
  }

  static List<Widget> backgroundPainterSetup(BuildContext context){
    return [
     Container(
        color: Color.fromRGBO(226, 235, 235, 1),
      ),
      CustomPaint(
        painter: BackgroundPainter(Color.fromRGBO(49, 73, 60, 0.3)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.23,
        ),
      ),
      CustomPaint(
        painter: BackgroundPainter(Color.fromRGBO(179, 239, 178, 1)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.22,
        ),
      ),
    ];
  }
}