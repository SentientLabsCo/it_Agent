import 'package:flutter/material.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Browse Files",
        style: TextStyle(fontSize: 28, color: Colors.white),
      ),
    );
  }
}
