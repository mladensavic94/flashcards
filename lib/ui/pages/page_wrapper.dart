import 'package:flashcards/model/quiz.dart';
import 'package:flashcards/ui/pages/edit_page.dart';
import 'package:flutter/material.dart';

import './home_page.dart';
import './settings_page.dart';
import './statistics_page.dart';

class PageWrapper extends StatefulWidget {
  @override
  _PageWrapperState createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  List<Widget> _pages = [Homepage(), StatisticsPage(), SettingsPage()];
  int _currentPageIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlashCards"),
        actions: _currentPageIndex == 0 ? [
        IconButton(
          icon: Icon(Icons.add),
          //TODO dummy implementation
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditPage(Quiz("", "", [], 0, 0)),
              )),
        )
        ] : [],
      ),
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => _changePage(value),
        currentIndex: _currentPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart), label: "Statistics"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
        ],
      ),
    );
  }
}
