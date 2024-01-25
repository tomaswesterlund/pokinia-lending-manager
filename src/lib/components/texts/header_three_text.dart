import 'package:flutter/material.dart';

class HeaderThreeText extends StatelessWidget {
  final String text;

  const HeaderThreeText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'SourceSans3', // Use the font family name you defined
        fontSize: 24.0, // Adjust font size as needed
        fontWeight: FontWeight.bold, // Specify the font weight
      ),
    );
  }
}