import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/loan_statements/loan_statement_table_component.dart';
import 'package:pokinia_lending_manager/components/loans/loan_summary_component.dart';
import 'package:pokinia_lending_manager/components/loans/loan_usar_status_component.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/models/loan_model.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:provider/provider.dart';

class LoanPage extends StatelessWidget {
  final String clientId;
  final String loanId;

  const LoanPage({super.key, required this.clientId, required this.loanId});

  @override
  Widget build(BuildContext context) {
    var clientService = Provider.of<ClientService>(context);
    var loanService = Provider.of<LoanService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Loan page"),
      ),
      body: StreamBuilder<ClientModel>(
        stream: clientService.getClientByIdStream(clientId),
        builder: (context, clientSnapshot) {
          if (clientSnapshot.hasError) {
            return const Center(child: Text("An error occurred"));
          } else if (clientSnapshot.hasData) {
            var client = clientSnapshot.data!;

            return StreamBuilder<LoanModel>(
              stream: loanService.getLoanByIdStream(loanId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var loan = snapshot.data!;

                  return Column(
                    children: [
                      LoanUserStatus(client: client, loan: loan),
                      LoanSummary(loan: loan),
                      LoanStatementTable(loanId: loanId),
                      const SizedBox(height: 50)
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
