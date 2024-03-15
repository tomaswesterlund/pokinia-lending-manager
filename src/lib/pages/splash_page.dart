import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokinia_lending_manager/components/texts/headers/giga_header_text.dart';
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
    _appService =
        ApplicationService(onAllListenersLoaded: onAllListenersLoaded);
    _appService.initializeListeners(context);

    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  void onAllListenersLoaded() {
    setState(() {
      Navigator.pushNamed(context, AuthPage.routeName);
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GigaHeaderText(text: "Pokinia", color: Colors.white),
                  GigaHeaderText(text: "Lending", color: Colors.white),
                  GigaHeaderText(text: "Manager", color: Colors.white),
                  GigaHeaderText(text: "", color: Colors.white),
                  GigaHeaderText(text: "", color: Colors.white),
                  GigaHeaderText(text: "", color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
