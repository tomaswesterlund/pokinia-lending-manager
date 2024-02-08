import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParagraphOneBoldText extends StatelessWidget {
  final String text;

  const ParagraphOneBoldText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
          textStyle: const TextStyle(
        fontSize: 16.0, // Adjust font size as needed
        fontWeight: FontWeight.bold, // Specify the font weight
      )),
    );
  }
}