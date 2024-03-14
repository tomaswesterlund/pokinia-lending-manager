import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';

// ignore: must_be_immutable
class SmallAmountText extends StatelessWidget {
  late String text;
  final FontWeight fontWeight;

  SmallAmountText(
      {super.key, required this.text, this.fontWeight = FontWeight.normal});

  SmallAmountText.withAmount(
      {super.key, required double amount, this.fontWeight = FontWeight.normal})
      : text = amount.toFormattedCurrency();

  SmallAmountText.withText(
      {super.key, required this.text, this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sourceCodePro(
          color: const Color(0xFF1C2829),
          textStyle: TextStyle(
            fontSize: 14.0, // Adjust font size as needed
            fontWeight: fontWeight, // Specify the font weight
          )),
    );
  }
}
