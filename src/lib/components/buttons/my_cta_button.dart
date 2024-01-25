import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/texts/my_sub_heading_text.dart';

class MyCtaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const MyCtaButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF008080),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: MySubHeadingText(text: text.toUpperCase()),
      ),
    );
  }
}
