import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParagraphThreeText extends StatelessWidget {
  final String text;
  final Color fillColor;
  final FontWeight fontWeight;

  const ParagraphThreeText(
      {super.key, required this.text, this.fillColor = const Color(0xFF1D2424), this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
          color: fillColor,
          textStyle: TextStyle(
            fontSize: 10.0, // Adjust font size as needed
            fontWeight: fontWeight, // Specify the font weight
          )),
    );
  }
}