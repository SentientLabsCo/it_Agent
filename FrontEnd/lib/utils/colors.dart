import 'package:flutter/material.dart';

const backgroundColor = Color.fromRGBO(36, 36, 36, 1);
const Color buttonColor = Color(0xFF1A237E);
const footerColor = Color.fromRGBO(26, 26, 26, 1);
const secondaryBackgroundColor = Color.fromRGBO(46, 46, 46, 1);

final backgoundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end:  Alignment.bottomRight,
  colors: [
    Color(0xFF1A237E), // Indigo dark
    Color(0xFF00BCD4), // Cyan
  ],
);