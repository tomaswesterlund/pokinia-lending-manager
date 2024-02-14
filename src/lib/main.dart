import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/pages/clients/clients_page.dart';
import 'package:pokinia_lending_manager/pages/main_page.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/file_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// TODO: Att start date to loan (?)
// TODO: Show "Remaining Amount" under the loan list?
// TODO: Handle partial payments?
// TODO: Cancel a payment? Add a reason?
// TODO: WHen doing chnages (e.g. to a payment) save the history
// TODO: When creating a payment, give choice to upload proof (comprobante etc.)
// TODO: CHebkbox (or something): Autogenerate payments based on latest payment plan (Monthly, 3% etc.) -> Done in backend ? When not activiated, as in case with Shay, just leaves as is

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// FIRESTORE EMULATOR
  // if (kDebugMode) {
  //   try {
  //     FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  //     await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print(e);
  //   }
  // }

// Needs to change depending on being runned locally or not!
// String baseApiUrl = "http://127.0.0.1:5001/pokinia-lending-manager-c66c7/us-central1/api";
  String baseApiUrl =
      "https://us-central1-pokinia-lending-manager-c66c7.cloudfunctions.net/api";

  ClientService clientService = ClientService(baseApiUrl: baseApiUrl);
  LoanService loanService = LoanService(baseApiUrl: baseApiUrl);
  LoanStatementService loanStatementService = LoanStatementService();
  PaymentService paymentService = PaymentService(baseApiUrl: baseApiUrl);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => clientService),
      ChangeNotifierProvider(create: (context) => loanService),
      ChangeNotifierProvider(create: (context) => loanStatementService),
      ChangeNotifierProvider(create: (context) => paymentService),
      
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
