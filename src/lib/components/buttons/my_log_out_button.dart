import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/texts/my_sub_heading_text.dart';

class MyLogOutButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isProcessing;

  const MyLogOutButton(
      {super.key, required this.onPressed, this.isProcessing = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isProcessing ? null : onPressed,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: isProcessing,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: const SizedBox(
                    height: 16.0,
                    width: 16.0,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
              ],
            ),
            const Icon(Icons.logout, color: Colors.white),
            const SizedBox(width: 12.0),
            MySubHeadingText(text: 'Log out'.toUpperCase()),
          ],
        ),
      ),
    );
  }
}
