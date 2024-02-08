import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/texts/headers/base_header_text.dart';

class HeaderFiveText extends StatelessWidget {
  final String text;

  const HeaderFiveText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return BaseHeaderText(text: text, fontSize: 18.0);
  }
}