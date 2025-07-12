/*
This is a section header widget that displays a title and result count.
Written by: [Arpit Raghuvanshi]
 */

import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {

  final String title;
  final int resultCount;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const SectionHeader({
    super.key,
    required this.title,
    required this.resultCount,
    this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Text(
              '$resultCount results',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
            SizedBox(width: 16),
            InkWell(
              onTap: onPrevious,
              child: Icon(
                Icons.chevron_left,
                color: Colors.grey[400],
              )
            ),
            SizedBox(width: 8),
            InkWell(
              onTap: onNext,
              child: Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
              )
            ),
          ],
        )
      ],
    );
  }
}
