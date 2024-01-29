import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BigPercentageText extends StatelessWidget {
  final double percentage;
  final formatCurrency = NumberFormat.simpleCurrency();

  BigPercentageText({super.key, required this.percentage});

  TextStyle get textStyle => GoogleFonts.sourceCodePro(
        color: const Color(0xFF1C2829),
        textStyle: const TextStyle(
          fontSize: 24.0, // Adjust font size as needed
          fontWeight: FontWeight.bold, // Specify the font weight
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Text('$percentage%', style: textStyle);
  }
}
