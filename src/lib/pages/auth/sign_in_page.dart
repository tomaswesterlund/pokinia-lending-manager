import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/components/boxes/square_tile.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/services/auth_service.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/services/toast_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInPage extends StatefulWidget {
  static String routeName = '/sign_in';

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final supabase = Supabase.instance.client;
  final Logger _logger = getLogger('SignInPage');
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[300],
        ),
        backgroundColor: Colors.grey[300],
        body: Center(
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
                          ToastService().showErrorToast(
                              'Something seems to have gone wrong, please try again.');
                        }
                      },
                      child: const SquareTile(
                          imagePath: 'assets/images/google.png')),

                  const SizedBox(width: 25),

                  // apple button
                  GestureDetector(
                      onTap: () => ToastService().showWarningToast(
                          'Apple sign in is not yet supported'),
                      child: const SquareTile(
                          imagePath: 'assets/images/apple.png'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
