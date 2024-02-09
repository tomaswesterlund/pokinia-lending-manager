import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/payments/payment_list_card_component.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/models/loan_statement_model.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:provider/provider.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var clientService = Provider.of<ClientService>(context);
    var loanStatementService = Provider.of<LoanStatementService>(context);
    var paymentService = Provider.of<PaymentService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const HeaderTwoText(text: "Payments"),
      ),
      body: OverduePayments(loanStatementService, clientService),
          
      );
    
  }

  StreamBuilder<List<LoanStatementModel>> OverduePayments(LoanStatementService loanStatementService, ClientService clientService) {
    return StreamBuilder(
      stream: loanStatementService.getOverdueLoanStatementsStream(),
      builder: (context, loanStatementsSnapshot) {
        if (loanStatementsSnapshot.hasError) {
          return const Center(
            child: HeaderThreeText(text: "Error loading loan statements"),
          );
        }

        if (loanStatementsSnapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var loanStatements = loanStatementsSnapshot.data!;

        if (loanStatements.isEmpty) {
          return const Center(
            child: HeaderThreeText(text: "No overdue loan statements"),
          );
        }

        return Column(
          children: [
            const HeaderThreeText(text: "Upcoming payments"),
            Expanded(
              child: ListView.builder(
                itemCount: loanStatements.length,
                itemBuilder: (context, index) {
                  var loanStatement = loanStatements[index];
              
                  return StreamBuilder<ClientModel>(
                    stream: clientService.getClientByIdStream(loanStatement.clientId),
                    builder: (context, clientSnapshot) {
                      if (clientSnapshot.hasError) {
                        return const Center(
                          child: HeaderThreeText(text: "Error loading client"),
                        );
                      }
              
                      if (clientSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
              
                      var client = clientSnapshot.data!;
                      
                      return PaymentListCard(client: client, loanStatement: loanStatement);
                    }
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Text upcomingPaymentsHeader() {
    return const Text(
      "Upcoming Payments",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
