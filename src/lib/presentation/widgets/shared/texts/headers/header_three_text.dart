import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/headers/base_header_text.dart';

class HeaderThreeText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;

  const HeaderThreeText(
      {super.key,
      required this.text,
      this.color = const Color(0xFF1D2424),
      this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return BaseHeaderText(
      text: text,
      color: color,
      fontSize: 24.0,
      fontWeight: fontWeight,
    );
  }
}
