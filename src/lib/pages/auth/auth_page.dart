import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/pages/customers/customer_page.dart';
import 'package:pokinia_lending_manager/pages/main_page.dart';
import 'package:pokinia_lending_manager/services/auth_service.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/services/user_settings_service.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final supabase = Supabase.instance.client;
  final Logger _logger = getLogger('AuthPage');
  final AuthService _authService = AuthService();
  AuthChangeEvent? _currentAuthEvent;

  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      setState(() {
        _currentAuthEvent = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (supabase.auth.currentUser != null) {
      // User already logged in
      return _signedInWidget();
    } else if (_currentAuthEvent == null) {
      return _loadingScreen();
    } else if (_currentAuthEvent == AuthChangeEvent.signedIn) {
      return _signedInWidget();
    } else {
      return _signInWidget();
    }
  }

  Widget _signedInWidget() {
    return Consumer<UserSettingsService>(
      builder: (context, userSettingsService, _) {
        var user = supabase.auth.currentUser!;
        userSettingsService.setUserId(user.id);

        if (userSettingsService.userSettings != null &&
            userSettingsService.userSettings?.selectedCustomerId != null) {
          return const MainPage();
        } else {
          return CustomerPage();
        }
      },
    );
  }

  Widget _signInWidget() {
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

  Widget _loadingScreen() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
