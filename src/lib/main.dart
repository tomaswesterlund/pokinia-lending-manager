import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/pages/clients/clients_page.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/providers/receipt_provider.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
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

  ClientService clientService = ClientService();
  LoanService loanService = LoanService();
  PaymentService paymentService = PaymentService();

  ReceiptProvider receiptProvider = ReceiptProvider();

  // LoanProvider loanProvider = LoanProvider(
  //   databaseService: databaseService,
  //   paymentProvider: paymentProvider,
  // );
  // ClientProvider clientProvider = ClientProvider(
  //   databaseService: databaseService,
  //   loanProvider: loanProvider,
  // );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => clientService),
      ChangeNotifierProvider(create: (context) => loanService),
      ChangeNotifierProvider(create: (context) => paymentService),
      ChangeNotifierProvider(create: (context) => receiptProvider),
      // StreamProvider<List<ClientModel>>(
      //   create: (context) => databaseService.getClientStream(),
      //   initialData: const [],
      // )
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
      home: const ClientsPage(),
    );
  }
}
