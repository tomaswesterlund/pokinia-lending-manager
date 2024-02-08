import 'package:flutter/material.dart';

class BaseHeaderText extends StatelessWidget {
  final String text;
  final double fontSize;
  const BaseHeaderText({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'SourceSans3', // Use the font family name you defined
        fontSize: fontSize, // Adjust font size as needed
        fontWeight: FontWeight.bold, // Specify the font weight
      ),
    );
  }
}