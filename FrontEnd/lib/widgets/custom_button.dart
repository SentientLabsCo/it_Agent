import 'package:flutter/material.dart';
import 'package:it_agent/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color? color;

  const CustomButton({
    super.key,
    required this.text,
    required this.height,
    required this.width,
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
        onPressed: () {},
        child: Text(text, style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
