import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigAmountText extends StatelessWidget {
  final String text;

  const BigAmountText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sourceCodePro(
          color: const Color(0xFF1C2829),
          textStyle: const TextStyle(
            fontSize: 24.0, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Specify the font weight
          )),
    );
  }
}
