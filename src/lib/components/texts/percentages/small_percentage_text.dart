import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SmallPercentageText extends StatelessWidget {
  final double percentage;
  final formatCurrency = NumberFormat.simpleCurrency();

  SmallPercentageText({super.key, required this.percentage});

  TextStyle get textStyle => GoogleFonts.sourceCodePro(
        color: const Color(0xFF1C2829),
        textStyle: const TextStyle(
          fontSize: 14.0, // Adjust font size as needed
          fontWeight: FontWeight.normal, // Specify the font weight
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Text('$percentage%', style: textStyle);
  }
}
