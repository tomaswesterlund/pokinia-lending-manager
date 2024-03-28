import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/my_sub_heading_text.dart';

class MyCancelButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const MyCancelButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF979797),
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
