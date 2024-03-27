import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/boostrap/bootstrap_repositories.dart';
import 'package:pokinia_lending_manager/core/boostrap/bootstrap_services.dart';
import 'package:pokinia_lending_manager/core/boostrap/bootstrap_supabase.dart';
import 'package:pokinia_lending_manager/core/boostrap/view_models/page_view_models.dart';
import 'package:pokinia_lending_manager/core/boostrap/view_models/widget_view_models.dart';
import 'package:pokinia_lending_manager/presentation/pages/auth/auth_page.dart';
import 'package:pokinia_lending_manager/presentation/pages/auth/sign_in_page.dart';
import 'package:pokinia_lending_manager/presentation/pages/main_page.dart';
import 'package:pokinia_lending_manager/presentation/pages/splash_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await bootstrapSupabase();
  await bootstrapRepositories();
  await bootstrapServices();

  runApp(
    MultiProvider(
      providers: [
        ...pageViewModels,
        ...widgetViewModels,
        
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokinia Lending Manager',
      initialRoute: AuthPage.routeName,
      routes: {
        SplashPage.routeName: (context) => const SplashPage(),
        AuthPage.routeName: (context) => const AuthPage(),
        SignInPage.routeName: (context) => const SignInPage(),
        MainPage.routeName: (context) => const MainPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
