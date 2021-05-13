import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;

  DrawerItem(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print(text),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Icon(icon),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}
