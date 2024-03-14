import 'package:flutter/material.dart';

class BaseBox extends StatelessWidget {
  final Widget child;
  const BaseBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        // height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF8F8F8),
          border: const Border(
            bottom: BorderSide(
              color: Color(0xFFD2DEE0),
            ),
          ),
        ),
        child: child);
  }
}
