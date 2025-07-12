/*
This is a Flutter widget for a custom button.
It allows customization of the button's text, width, height, color, and onPressed callback.
Author: [Arpit Raghuvanshi]
*/

import 'package:flutter/material.dart';
import 'package:it_agent/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color? color;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.height,
    required this.width,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? buttonColor),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
