import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/services/application_service.dart';
import 'package:pokinia_lending_manager/ui/pages/auth/auth_page.dart';

class SplashPage extends StatefulWidget {
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
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AuthPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
   return Image.asset('assets/images/splash_background.jpg');
  }
}
