import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/headers/base_header_text.dart';

class GigaHeaderText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;

  const GigaHeaderText(
      {super.key,
      required this.text,
      this.color = const Color(0xFF1D2424),
      this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return BaseHeaderText(
      text: text,
      color: color,
      fontSize: 64.0,
      fontWeight: fontWeight,
    );
  }
}
