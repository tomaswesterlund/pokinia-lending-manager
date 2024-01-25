import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AmountText extends StatelessWidget {
  final int amount;
  final formatCurrency = NumberFormat.simpleCurrency();

  AmountText({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Text(
      formatCurrency.format(amount),
      style: GoogleFonts.sourceCodePro(
          textStyle: const TextStyle(
        fontSize: 24.0, // Adjust font size as needed
        fontWeight: FontWeight.bold, // Specify the font weight
      )),
    );
  }
}
