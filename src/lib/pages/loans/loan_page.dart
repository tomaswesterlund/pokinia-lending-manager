import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/loan_statements/loan_statement_table_component.dart';
import 'package:pokinia_lending_manager/components/loans/loan_summary_component.dart';
import 'package:pokinia_lending_manager/components/loans/loan_user_status_component.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:provider/provider.dart';

class LoanPage extends StatelessWidget {
  final String clientId;
  final String loanId;

  const LoanPage({super.key, required this.clientId, required this.loanId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loan page"),
      ),
      body: Consumer2<ClientService, LoanService>(
        builder: (context, clientService, loanService, _) {
          var client = clientService.getClientById(clientId);
          var loan = loanService.getLoanById(loanId);
          return Column(
            children: [
              LoanUserStatus(client: client, loan: loan),
              LoanSummary(loan: loan),
              LoanStatementTable(loanId: loanId),
              const SizedBox(height: 50)
            ],
          );
        },
      ),
    );
  }
}
