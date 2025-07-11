/*
This is a Flutter widget for creating a custom card.
It allows displaying a title, an icon, and an optional button.
The card can be styled as compact or full layout.
Author: [Arpit Raghuvanshi]
*/

import 'package:flutter/material.dart';
import 'package:it_agent/utils/colors.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String? buttonText;
  final VoidCallback? onPressed;
  final double height;
  final bool isCompact;

  const CustomCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    this.buttonText,
    this.onPressed,
    this.height = 200,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(isCompact ? 16 : 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: isCompact ? _buildCompactLayout() : _buildFullLayout(),
    );
  }

  Widget _buildCompactLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFullLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: iconColor == Colors.white
                ? Colors.white
                : iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: iconColor == Colors.white ? Colors.black : iconColor,
            size: 24,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        if (buttonText != null)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF000419),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                )
              ),
              child: Text(buttonText!),
            ),
          ),
      ],
    );
  }
}
