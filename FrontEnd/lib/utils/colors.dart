import 'package:flutter/material.dart';

const backgroundColor = Color.fromRGBO(0, 4, 32, 1.0);
const Color buttonColor = Color(0xFF1A237E);
const chipColor = Color(0xFF2C2C40);
const fontColor = Color(0xFFBDD5E7);
const drawerColor = Color(0xFF2C2C40);

final backgroundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end:  Alignment.bottomRight,
  colors: [
    Color(0xFF000429), // Indigo dark
    Color(0xFF14153A), // Cyan
  ],
);