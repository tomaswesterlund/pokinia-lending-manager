import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';

class SmallAmountText extends StatelessWidget {
  late String text;

  SmallAmountText({super.key, required this.text});

  SmallAmountText.withAmount({super.key, required double amount})
      : text = amount.toFormattedCurrency();

      SmallAmountText.withText({super.key, required this.text});

  

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sourceCodePro(
          color: const Color(0xFF1C2829),
          textStyle: const TextStyle(
            fontSize: 14.0, // Adjust font size as needed
            fontWeight: FontWeight.normal, // Specify the font weight
          )),
    );
  }
}
