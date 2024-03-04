import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/pages/auth/auth_page.dart';
import 'package:pokinia_lending_manager/pages/loans/loans_page.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/customer_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:pokinia_lending_manager/services/user_settings_service.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// TODO: Att start date to loan (?)
// TODO: Show "Remaining Amount" under the loan list?
// TODO: Handle partial payments?
// TODO: Cancel a payment? Add a reason?
// TODO: WHen doing chnages (e.g. to a payment) save the history
// TODO: When creating a payment, give choice to upload proof (comprobante etc.)
// TODO: CHebkbox (or something): Autogenerate payments based on latest payment plan (Monthly, 3% etc.) -> Done in backend ? When not activiated, as in case with Shay, just leaves as is

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SUPABASE
  await Supabase.initialize(
    url: 'https://gjgdunpydpudivcfohxv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdqZ2R1bnB5ZHB1ZGl2Y2ZvaHh2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDg2ODk0MDAsImV4cCI6MjAyNDI2NTQwMH0.E92dy2RI0h4kgJxTZOTuAIICPKhXGKy2Fk2QZgGDjNM',
  );

  // if (kDebugMode) {
  //   await Supabase.initialize(
  //     url: 'http://127.0.0.1:54321',
  //     anonKey:
  //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
  //   );
  // } else {
  //   await Supabase.initialize(
  //     url: 'https://gjgdunpydpudivcfohxv.supabase.co',
  //     anonKey:
  //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdqZ2R1bnB5ZHB1ZGl2Y2ZvaHh2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDg2ODk0MDAsImV4cCI6MjAyNDI2NTQwMH0.E92dy2RI0h4kgJxTZOTuAIICPKhXGKy2Fk2QZgGDjNM',
  //   );
  // }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserSettingsService()),
      ChangeNotifierProvider(create: (context) => CustomerService()),
      ChangeNotifierProvider(create: (context) => ClientService()),
      ChangeNotifierProvider(create: (context) => LoanService()),
      ChangeNotifierProvider(create: (context) => LoanStatementService()),
      ChangeNotifierProvider(create: (context) => PaymentService()),
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
      title: 'Pokinia Lending Manager',
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const AuthPage(),
        '/loans':(context) => const LoansPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      //home: const AuthPage(),
    );
  }
}
