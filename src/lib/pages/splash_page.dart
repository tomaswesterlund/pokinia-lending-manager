import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/pages/auth/auth_page.dart';
import 'package:pokinia_lending_manager/services/application_service.dart';

class SplashPage extends StatefulWidget {
  static String routeName = '/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late ApplicationService _appService;

  @override
  void initState() {
    _appService = ApplicationService(onAllListenersLoaded: onAllListenersLoaded);
    _appService.initializeListeners(context);

    super.initState();
  }

  void onAllListenersLoaded() {
    setState(() {
      Navigator.pushNamed(context, AuthPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
   return Image.asset('assets/images/splash_background.jpg');
  }
}
