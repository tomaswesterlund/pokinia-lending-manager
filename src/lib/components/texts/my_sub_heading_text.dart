import 'package:flutter/material.dart';

class MySubHeadingText extends StatelessWidget {
  final String text;
  const MySubHeadingText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'SourceSans3', // Use the font family name you defined
        fontSize: 14.0, // Adjust font size as needed
        fontWeight: FontWeight.w600
      ),
    );
  }
}
