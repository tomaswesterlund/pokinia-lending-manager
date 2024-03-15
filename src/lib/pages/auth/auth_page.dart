import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokinia_lending_manager/pages/auth/sign_in_page.dart';
import 'package:pokinia_lending_manager/pages/main_page.dart';
import 'package:pokinia_lending_manager/providers/organization_provider.dart';
import 'package:pokinia_lending_manager/providers/user_settings_provider.dart';
import 'package:pokinia_lending_manager/services/toast_service.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends StatefulWidget {
  static String routeName = '/auth';

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

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  void setupOnAuthStateChange() {
    supabase.auth.onAuthStateChange.listen((data) async {
      try {
        final event = data.event;
        var session = supabase.auth.currentSession;

        if (session != null) {
          var user = session.user;

          var userSettingsProvider =
              Provider.of<UserSettingsProvider>(context, listen: false);

          if (!userSettingsProvider.hasUserSettingsForUser(user.id)) {
            var organizationProvider =
                Provider.of<OrganizationProvider>(context, listen: false);
            var response = await organizationProvider
                .createOrganization('My first organization');
            var organizationId = response.data[0]['id'] as String;
            await userSettingsProvider.createUserSettings(
                user.id, organizationId);
          }

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainPage()));
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
          Navigator.pushNamed(context, MainPage.routeName);
        }

        if (event == AuthChangeEvent.signedOut) {
          Navigator.pushNamed(context, SignInPage.routeName);
        }

        setState(() {
          _currentAuthEvent = event;
        });
      } catch (e) {
        ToastService().showErrorToast('An error occurred while signing in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      child: SignInPage(),
    );
  }
}
