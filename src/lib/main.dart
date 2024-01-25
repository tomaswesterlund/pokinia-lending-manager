import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/pages/clients/clients_page.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClientProvider()),
      ],
      child: const MyApp(),
    )
  );

  
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
