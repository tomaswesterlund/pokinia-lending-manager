import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParagraphThreeText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;

  const ParagraphThreeText(
      {super.key, required this.text, this.color = const Color(0xFF1D2424), this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
          color: color,
          textStyle: TextStyle(
            fontSize: 10.0, // Adjust font size as needed
            fontWeight: fontWeight, // Specify the font weight
          )),
    );
  }
}
