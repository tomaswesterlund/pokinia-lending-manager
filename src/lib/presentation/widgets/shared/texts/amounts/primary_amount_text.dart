import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryAmountText extends StatelessWidget {
  final String text;

  const PrimaryAmountText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sourceCodePro(
          color: const Color(0xFF008080),
          textStyle: const TextStyle(
            fontSize: 32.0, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Specify the font weight
          )),
    );
  }
}
