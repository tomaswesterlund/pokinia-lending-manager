import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/services/auth_service.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInPage extends StatelessWidget {
  final supabase = Supabase.instance.client;
  final Logger _logger = getLogger('SignInPage');
  final AuthService _authService = AuthService();
  
  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await _authService.signInWithGoogle();
            } catch (e) {
              _logger.e(e);
            }
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}