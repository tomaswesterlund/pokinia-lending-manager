import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:pokinia_lending_manager/providers/customer_provider.dart';
import 'package:pokinia_lending_manager/providers/loan_statement_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/open_ended_loan_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/zero_interest_loan_provider.dart';
import 'package:pokinia_lending_manager/providers/organization_provider.dart';
import 'package:pokinia_lending_manager/providers/organization_settings_provider.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/providers/user_settings_provider.dart';
import 'package:pokinia_lending_manager/services/log_service.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApplicationService {
  final LogService _logger = LogService('ApplicationService');
  final supabase = Supabase.instance.client;

  final Function onAllListenersLoaded;

  ApplicationService({required this.onAllListenersLoaded});

  final Map<String, bool> _listenersLoaded = {
    'ClientProvider': false,
    'CustomerProvider': false,
    'LoanProvider': false,
    'openEndedLoanService': false,
    'zeroInterestLoanService': false,
    'loanStatementService': false,
    'organizationService': false,
    'paymentService': false,
    'userSettingsService': false,
    'OrganizationSettingsProvider': false
  };

  // final bool _userSettingsInitialized = false;
  // bool get userSettingsInitialized => _userSettingsInitialized;

  void initializeListeners(BuildContext context) async {
    try {
      Provider.of<ClientProvider>(context, listen: false)
          .startListener(onListenerLoaded);

      Provider.of<CustomerProvider>(context, listen: false)
          .startListener(onListenerLoaded);

      Provider.of<LoanProvider>(context, listen: false)
          .startListener(onListenerLoaded);

      Provider.of<LoanStatementProvider>(context, listen: false)
          .startListener(onListenerLoaded);

      Provider.of<PaymentProvider>(context, listen: false)
          .startListener(onListenerLoaded);

      Provider.of<OpenEndedLoanProvider>(context, listen: false)
          .startListener(onListenerLoaded);

      Provider.of<OrganizationProvider>(context, listen: false)
          .startListener(onListenerLoaded);

      Provider.of<OrganizationSettingsProvider>(context, listen: false)
          .startListener(onListenerLoaded);

      Provider.of<UserSettingsProvider>(context, listen: false)
          .startListener(onListenerLoaded);

      Provider.of<ZeroInterestLoanProvider>(context, listen: false)
          .startListener(onListenerLoaded);
    } catch (e) {
      _logger.e('initializeListeners', e.toString());
      rethrow;
    }
  }

  void onListenerLoaded(String source) {
    _listenersLoaded[source] = true;

    if (_listenersLoaded.values.every((loaded) => loaded)) {
      onAllListenersLoaded();
    }
  }
}
