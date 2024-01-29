import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParagraphOneRegularText extends StatelessWidget {
  final String text;

  const ParagraphOneRegularText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
          color: const Color(0xFF9EA6A7),
          textStyle: const TextStyle(
            fontSize: 16.0, // Adjust font size as needed
            fontWeight: FontWeight.normal, // Specify the font weight
          )),
    );
  }
}
