import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/pages/clients/clients_page.dart';
import 'package:pokinia_lending_manager/pages/loans/loans_page.dart';
import 'package:pokinia_lending_manager/pages/payments/payments_page.dart';
import 'package:pokinia_lending_manager/pages/reports/reports_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;

  Widget _getPage() {
    if (currentPageIndex == 0) {
      return const PaymentsPage();
    } else if (currentPageIndex == 1) {
      return LoansPage();
    } else if (currentPageIndex == 2) {
      return const ClientsPage();
    } else if (currentPageIndex == 3) {
      return const ReportsPage();
    } else {
      throw Exception("Invalid index");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.payments), label: "Payments"),
            NavigationDestination(icon: Icon(Icons.monetization_on), label: "Loans"),
            NavigationDestination(icon: Icon(Icons.group), label: "Clients"),
            NavigationDestination(icon: Icon(Icons.bar_chart), label: "Reports"),
          ],
          onDestinationSelected: (value) {
            setState(() {
              currentPageIndex = value;
            });
          },
        ),
        body: _getPage(),
      ),
    );
  }
}
