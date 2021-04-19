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
}