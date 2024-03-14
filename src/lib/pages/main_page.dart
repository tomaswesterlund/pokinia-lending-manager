import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/pages/clients/clients_page.dart';
import 'package:pokinia_lending_manager/pages/loans/loans_page.dart';
import 'package:pokinia_lending_manager/pages/settings/settings_page.dart';

class MainPage extends StatefulWidget {
  static String routeName = '/main';
  
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;

  Widget _getPage() {
    if (currentPageIndex == 0) {
      return const ClientsPage();
    } else if (currentPageIndex == 1) {
      return const LoansPage();
    } else if (currentPageIndex == 2) {
      return  SettingsPage();
    } else {
      throw Exception("Invalid index");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.group), label: "Clients"),
          NavigationDestination(
              icon: Icon(Icons.monetization_on), label: "Loans"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
      ),
      body: _getPage(),
    );
  }
}
