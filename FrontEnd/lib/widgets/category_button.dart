/*
This is a Flutter widget for a category button.
It is designed to be used in a grid layout, allowing users to select different categories.
It includes a text label, an icon, and customizable colors for the background, text, and border.
Author: [Arpit Raghuvanshi]
 */

import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const CategoryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor = const Color(0xFF01072C),
    this.textColor = Colors.white,
    this.borderColor = const Color(0xFF01082E),
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
