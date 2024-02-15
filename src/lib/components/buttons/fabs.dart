import 'package:flutter/material.dart';

FloatingActionButton getDefaultFab({required VoidCallback onPressed}) =>
    FloatingActionButton(
      backgroundColor: const Color(0xFF008080),
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
