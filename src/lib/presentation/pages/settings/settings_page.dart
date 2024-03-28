import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/pages/settings/account_settings_page.dart';
import 'package:pokinia_lending_manager/presentation/pages/settings/client_settings_page.dart';
import 'package:pokinia_lending_manager/presentation/pages/settings/loan_settings_page.dart';
import 'package:pokinia_lending_manager/presentation/pages/settings/loan_statement_settings_page.dart';
import 'package:pokinia_lending_manager/presentation/pages/settings/payment_settings_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/boxes/base_box.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/headers/header_two_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsPage extends StatelessWidget {
  final SupabaseClient _supabase = Supabase.instance.client;

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HeaderTwoText(text: 'Settings'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // _getButton(
              //     'General settings',
              //     () => Navigator.push(context,
              //             MaterialPageRoute(builder: (context) {
              //           return const GeneralSettings();
              //         }))),
              _getButton(
                  'Client settings',
                  () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ClientSettings();
                      }))),
              _getButton(
                  'Loan settings',
                  () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoanSettings();
                      }))),
              _getButton(
                  'Loan statement settings',
                  () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoanStatementSettings();
                      }))),
              _getButton(
                  'Payment settings',
                  () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const PaymentSettings();
                      }))),
              // _getButton(
              //     'Currency settings',
              //     () => Navigator.push(context,
              //             MaterialPageRoute(builder: (context) {
              //           return const CurrencySettings();
              //         }))),
              _getButton(
                  'Account settings',
                  () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AccountSettings();
                      }))),

              const SizedBox(height: 32.0),
            ],
          )
    );
  }

  Widget _getButton(String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: BaseBox(
        child: Row(
          children: [
            HeaderFourText(text: title),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
