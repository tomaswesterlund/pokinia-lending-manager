import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryAmountRedText extends StatelessWidget {
  String text;

  PrimaryAmountRedText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sourceCodePro(
          color: Colors.red,
          textStyle: const TextStyle(
            fontSize: 32.0, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Specify the font weight
          )),
    );
  }
}
