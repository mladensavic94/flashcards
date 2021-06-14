import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  final Widget icon;
  final Text text;

  const IconAndText({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        text
      ],
    );
  }
}
