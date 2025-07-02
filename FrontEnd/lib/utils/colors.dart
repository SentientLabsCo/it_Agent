import 'package:flutter/material.dart';

const backgroundColor = Color.fromRGBO(0, 4, 32, 1.0);
const Color buttonColor = Color(0xFF1A237E);
const chipColor = Color(0xFF2C2C40);
const fontColor = Color(0xFFBDD5E7);
const drawerColor = Color(0xFF2C2C40);
const cardColor = Color(0xFF01072C);

final backgroundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end:  Alignment.bottomRight,
  colors: [
    Color(0xFF000429), // Indigo dark
    Color(0xFF14153A), // Cyan
  ],
);

final headerGradient = LinearGradient(
  colors: [
    Color(0xFF4A90E2),
    Color(0xFF7B68EE),
    Color(0xFF9370DB),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);