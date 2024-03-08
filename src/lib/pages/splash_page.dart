import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/customer_service.dart';
import 'package:pokinia_lending_manager/services/loans/loan_service.dart';
import 'package:pokinia_lending_manager/services/loans/open_ended_loan_service.dart';
import 'package:pokinia_lending_manager/services/loans/zero_interest_loan_service.dart';
import 'package:pokinia_lending_manager/services/user_settings_service.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<CustomerService, ClientService, UserSettingsService>(
      builder:
          (context, customerService, clientService, userSettingsService, _) {
        return Consumer3<LoanService, OpenEndedLoanService,
            ZeroInterestLoanService>(
          builder: (context, loanService, openEndedLoanService,
              zeroInterestLoanService, _) {
            if (!customerService.loaded ||
                !clientService.loaded ||
                !userSettingsService.loaded ||
                !loanService.loaded ||
                !openEndedLoanService.loaded ||
                !zeroInterestLoanService.loaded) {
              return Image.asset('assets/images/splash_background.jpg');
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(context, '/auth');
              });

              return Container(color: Colors.transparent);
            }
          },
        );
      },
    );
  }
}
