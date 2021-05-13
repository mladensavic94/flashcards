import 'drawer_item.dart';
import 'package:flutter/material.dart';

class FlashcardDrawer extends StatefulWidget {
  @override
  _FlashcardDrawerState createState() => _FlashcardDrawerState();
}

class _FlashcardDrawerState extends State<FlashcardDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Theme.of(context).primaryColor))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "NAME",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text("app version",
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ),
          ),
          DrawerItem(Icons.home, "Home"),
          DrawerItem(Icons.insert_chart, "Statistics"),
          DrawerItem(Icons.settings, "Settings"),
          DrawerItem(Icons.logout, "Log out"),
          Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Theme.of(context).primaryColor))))
        ],
      ),
    );
  }
}
