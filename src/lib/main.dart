import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/pages/auth/auth_page.dart';
import 'package:pokinia_lending_manager/pages/auth/sign_in_page.dart';
import 'package:pokinia_lending_manager/pages/main_page.dart';
import 'package:pokinia_lending_manager/pages/splash_page.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:pokinia_lending_manager/providers/customer_provider.dart';
import 'package:pokinia_lending_manager/providers/loan_statement_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/open_ended_loan_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/zero_interest_loan_provider.dart';
import 'package:pokinia_lending_manager/providers/organization_provider.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/providers/user_settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SUPABASE
  await Supabase.initialize(
    url: 'https://gjgdunpydpudivcfohxv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdqZ2R1bnB5ZHB1ZGl2Y2ZvaHh2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDg2ODk0MDAsImV4cCI6MjAyNDI2NTQwMH0.E92dy2RI0h4kgJxTZOTuAIICPKhXGKy2Fk2QZgGDjNM',
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ClientProvider()),
      ChangeNotifierProvider(create: (context) => CustomerProvider()),
      ChangeNotifierProvider(create: (context) => LoanProvider()),
      ChangeNotifierProvider(create: (context) => LoanStatementProvider()),
      ChangeNotifierProvider(create: (context) => PaymentProvider()),
      ChangeNotifierProvider(create: (context) => OpenEndedLoanProvider()),
      ChangeNotifierProvider(create: (context) => OrganizationProvider()),
      ChangeNotifierProvider(create: (context) => UserSettingsProvider()),
      ChangeNotifierProvider(create: (context) => ZeroInterestLoanProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokinia Lending Manager',
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => const SplashPage(),
        AuthPage.routeName: (context) => const AuthPage(),
        SignInPage.routeName: (context) => SignInPage(),
        MainPage.routeName: (context) => const MainPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
