import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParagraphTwoRegularText extends StatelessWidget {
  final String text;

  const ParagraphTwoRegularText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
          color: const Color(0xFF1D2424),
          textStyle: const TextStyle(
            fontSize: 14.0, // Adjust font size as needed
            fontWeight: FontWeight.normal, // Specify the font weight
          )),
    );
  }
}
