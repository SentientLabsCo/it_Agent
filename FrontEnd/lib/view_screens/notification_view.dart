import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Notifications",
        style: TextStyle(fontSize: 28, color: Colors.white),
      ),
    );
  }
}
