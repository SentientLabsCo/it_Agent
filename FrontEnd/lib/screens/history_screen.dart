/*
This is a Flutter widget for the history screen of an IT support application.
It is designed to display the history logs of user interactions or system events.
And this need to be implemented further to show actual history data.

*/

import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "History Logs",
        style: TextStyle(fontSize: 28, color: Colors.white),
      ),
    );
  }
}
