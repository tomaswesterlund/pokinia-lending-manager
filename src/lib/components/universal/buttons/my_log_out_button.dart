import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/my_sub_heading_text.dart';

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
        child: Center(
          child: Row(
            children: <Widget>[
              const Icon(Icons.logout, color: Colors.white),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    MySubHeadingText(text: 'Log out'.toUpperCase()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
