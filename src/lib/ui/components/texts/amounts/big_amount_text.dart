import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigAmountText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;

  const BigAmountText({super.key, required this.text, this.color = const Color(0xFF1C2829), this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sourceCodePro(
          color: color,
          textStyle:  TextStyle(
            fontSize: 24.0, // Adjust font size as needed
            fontWeight: fontWeight, // Specify the font weight
          )),
    );
  }
}
