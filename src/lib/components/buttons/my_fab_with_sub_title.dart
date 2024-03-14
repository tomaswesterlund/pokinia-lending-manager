import 'package:flutter/material.dart';

class MyFabWithSubTitle extends StatelessWidget {
  final String? subTitle;
  final VoidCallback? onPressed;

  const MyFabWithSubTitle({super.key, required this.subTitle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          backgroundColor: const Color(0xFF008080),
          onPressed: onPressed,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        if (subTitle != null)
          Text(
            subTitle!.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF008080),
              fontFamily: 'SourceSans3', // Use the font family name you defined
              fontSize: 14.0, // Adjust font size as needed
              fontWeight: FontWeight.w600, // Specify the font weight
            ),
          )
      ],
    );
  }
}
