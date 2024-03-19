import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
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
          body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Center(child: HeaderTwoText(text: 'Pokinia Lending Manager')),
            ),
            //Lottie.asset('assets/animations/bank.json'),
            const Spacer(),
            Lottie.asset('assets/animations/loading.json'),
          ],
        ),
      )),
    );
  }
}
