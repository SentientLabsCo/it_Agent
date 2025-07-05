import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

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
