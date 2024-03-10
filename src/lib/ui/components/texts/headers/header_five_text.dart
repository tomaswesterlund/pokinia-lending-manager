import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/ui/components/texts/headers/base_header_text.dart';

class HeaderFiveText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;

  const HeaderFiveText({super.key, required this.text, this.color = const Color(0xFF1D2424), this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return BaseHeaderText(text: text, color: color, fontSize: 18.0, fontWeight: fontWeight);
  }
}
