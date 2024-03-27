import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isProcessing;
  const MyAppBar({super.key, required this.title, required this.isProcessing});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isProcessing
          ? const IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: null, // This disables the button
            color: Colors.grey, // Optional: makes it look disabled
          )
          : IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop(); // Enables the back functionality
              },
            ),
      title: Text(title),
    );
  }
}
