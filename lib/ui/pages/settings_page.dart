import 'package:flutter/material.dart';
import '../../model/constants.dart';

class SettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...Constants.backgroundPainterSetup(context),
        Center(
          child: Text("Settings"),
        )
      ],
    );
  }
}
