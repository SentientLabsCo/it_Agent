import 'package:flutter/material.dart';
import 'package:it_agent/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'IT Agent',
      // routes: {
      //   '/': (context) => const LoginScreen(),
      // },
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

