import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/providers/organization_provider.dart';
import 'package:pokinia_lending_manager/providers/user_settings_provider.dart';
import 'package:pokinia_lending_manager/ui/pages/auth/sign_in_page.dart';
import 'package:pokinia_lending_manager/ui/pages/main_page.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final supabase = Supabase.instance.client;
  AuthChangeEvent _currentAuthEvent = AuthChangeEvent.initialSession;

  @override
  void initState() {
    setupOnAuthStateChange();
    super.initState();
  }

  void setupOnAuthStateChange() {
    supabase.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      var session = supabase.auth.currentSession;

      if (session != null) {
        var user = session.user;

        var userSettingsProvider =
            Provider.of<UserSettingsProvider>(context, listen: false);

        if (!userSettingsProvider.hasUserSettingsForUser(user.id)) {
          var organizationProvider = Provider.of<OrganizationProvider>(context, listen: false);
          var response = await organizationProvider.createOrganization('My first organization');
          var organizationId = response.data[0]['id'] as String;
          await userSettingsProvider.createUserSettings(user.id, organizationId);
        }
        
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      }

      if (event == _currentAuthEvent) {
        return;
      }

      if (event == AuthChangeEvent.initialSession) {
        return;
      }

      if (event == AuthChangeEvent.tokenRefreshed) {
        return;
      }

      if (event == AuthChangeEvent.signedIn) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      }

      setState(() {
        _currentAuthEvent = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SignInPage();
  }

  Widget _loadingScreen() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
