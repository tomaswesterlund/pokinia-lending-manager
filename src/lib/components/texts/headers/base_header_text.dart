import 'package:flutter/material.dart';

class BaseHeaderText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  const BaseHeaderText({super.key, required this.text, required this.fontSize, this.fontWeight = FontWeight.bold, this.color = const Color(0xFF1D2424)});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'SourceSans3', // Use the font family name you defined
        fontSize: fontSize, // Adjust font size as needed
        fontWeight: fontWeight, // Specify the font weight
      ),
    );
  }
}