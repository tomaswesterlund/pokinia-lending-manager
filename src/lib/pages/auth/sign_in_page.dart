import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/components/boxes/square_tile.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/services/auth_service.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/services/toast_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInPage extends StatelessWidget {
  static String routeName = '/sign_in';
  final supabase = Supabase.instance.client;
  final Logger _logger = getLogger('SignInPage');
  final AuthService _authService = AuthService();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const HeaderTwoText(text: 'Pokinia Lending Manager'),
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              Text(
                'Please choose how to login',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 50),

              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  GestureDetector(
                      onTap: () async {
                        try {
                          await _authService.signInWithGoogle();
                        } catch (e) {
                          _logger.e(e);
                          ToastService().showErrorToast('Something seems to have gone wrong, please try again.');
                        }
                      },
                      child: const SquareTile(
                          imagePath: 'assets/images/google.png')),

                  const SizedBox(width: 25),

                  // apple button
                  GestureDetector(
                    onTap: () => ToastService().showWarningToast('Apple sign in is not yet supported'),
                    child: const SquareTile(imagePath: 'assets/images/apple.png'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
