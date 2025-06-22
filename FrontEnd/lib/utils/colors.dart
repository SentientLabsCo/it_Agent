import 'package:flutter/material.dart';

const backgroundColor = Color.fromRGBO(0, 4, 32, 1.0);
const Color buttonColor = Color(0xFF1A237E);
const footerColor = Color.fromRGBO(26, 26, 26, 1);
const secondaryBackgroundColor = Color.fromRGBO(46, 46, 46, 1);

final backgoundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end:  Alignment.bottomRight,
  colors: [
    Color(0xFF000429), // Indigo dark
    Color(0xFF14153A), // Cyan
  ],
);