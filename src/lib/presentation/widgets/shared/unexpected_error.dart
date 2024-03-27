import 'package:flutter/material.dart';

class UnexpectedError extends StatelessWidget {
  const UnexpectedError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("An error occurred. Please try again later."),
    );
  }
}