import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BigAmountText extends StatelessWidget {
  final double amount;
  String formattedAmount = '';

  BigAmountText({super.key, required this.amount}) {
    formattedAmount = NumberFormat.simpleCurrency(locale: 'en-US', decimalDigits: 0)
        .format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedAmount,
      style: GoogleFonts.sourceCodePro(
          color: const Color(0xFF1C2829),
          textStyle: const TextStyle(
            fontSize: 24.0, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Specify the font weight
          )),
    );
  }
}
