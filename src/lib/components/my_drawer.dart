import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/services/auth_service.dart';

class MyDrawer extends StatelessWidget {
  final AuthService _authService = AuthService();

  MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(onPressed: () {
            _authService.signOut();
          }, child: const Text("Log out")),
        ],
      ),
    );
  }
}
