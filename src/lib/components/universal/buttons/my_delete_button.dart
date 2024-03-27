import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/my_sub_heading_text.dart';

class MyDeleteButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const MyDeleteButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.red,
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
