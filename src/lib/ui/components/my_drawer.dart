import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/services/auth_service.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context, listen: false);

    return Center(
      child: Column(
        children: [
          ElevatedButton(onPressed: () {
            authService.signOut();
          }, child: const Text("Log out")),
        ],
      ),
    );
  }
}
