import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokinia_lending_manager/components/universal/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/presentation/pages/clients/clients_page.dart';
import 'package:pokinia_lending_manager/presentation/pages/loans/loans_page.dart';
import 'package:pokinia_lending_manager/presentation/pages/settings/settings_page.dart';
import 'package:pokinia_lending_manager/view_models/pages/main_page_view_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  static String routeName = '/main';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  int currentPageIndex = 0;

  Widget _getPage() {
    if (currentPageIndex == 0) {
      return const ClientsPage();
    } else if (currentPageIndex == 1) {
      return const LoansPage();
    } else if (currentPageIndex == 2) {
      return SettingsPage();
    } else {
      throw Exception("Invalid index");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageViewModel>(
      builder: (context, vm, _) {
        if (vm.state == States.loading) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 20.0),
                  child: Center(child: HeaderTwoText(text: 'Initializing ...')),
                ),
                const ParagraphOneText(text: 'Please wait'),
                Lottie.asset('assets/animations/loading.json'),
              ],
            ),
          );
        } else if (vm.state == States.error) {
          return const Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 20.0),
                  child: Center(child: HeaderTwoText(text: 'Error')),
                ),
                ParagraphOneText(text: 'An error occurred'),
              ],
            ),
          );
        } else if (vm.state == States.ready) {
          return Scaffold(
            bottomNavigationBar: NavigationBar(
              selectedIndex: currentPageIndex,
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.group), label: "Clients"),
                NavigationDestination(
                    icon: Icon(Icons.monetization_on), label: "Loans"),
                NavigationDestination(
                    icon: Icon(Icons.settings), label: "Settings"),
              ],
              onDestinationSelected: (value) {
                setState(() {
                  currentPageIndex = value;
                });
              },
            ),
            body: _getPage(),
          );
        } else {
          throw Exception("Invalid state");
        }
      },
    );
  }
}
