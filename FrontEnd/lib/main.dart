import 'dart:io';
import 'package:flutter/material.dart';
import 'package:it_agent/screens/login_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: const Size(1200, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    //titleBarStyle: TitleBarStyle.hidden,
    //windowButtonVisibility: false,
    fullScreen: Platform.isMacOS,
    minimumSize: Size(800, 600)
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async{
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT Assistant',
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

