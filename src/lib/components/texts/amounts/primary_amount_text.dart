import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PrimaryAmountText extends StatelessWidget {
  final double amount;
  String formattedAmount = '';

  PrimaryAmountText({super.key, required this.amount}) {
    formattedAmount = NumberFormat.simpleCurrency(locale: 'en-US', decimalDigits: 0)
        .format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedAmount,
      style: GoogleFonts.sourceCodePro(
        color: const Color(0xFF008080),
          textStyle: const TextStyle(
        fontSize: 32.0, // Adjust font size as needed
        fontWeight: FontWeight.bold, // Specify the font weight
      )),
    );
  }
}
