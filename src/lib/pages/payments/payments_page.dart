import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/payments/payment_list_card_component.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer4<ClientService, LoanService, LoanStatementService,
          PaymentService>(
        builder: (context, clientService, loanService, loanStatementService,
            paymentService, _) {
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: HeaderTwoText(text: "Payments"),
                scrolledUnderElevation: 0,
                floating: true,
              ),
              loanStatementService.getOverdueLoanStatements().isEmpty &&
                      paymentService.getRecentlyPaidPayments().isEmpty
                  ? const SliverFillRemaining(
                      child: Center(child: Text("No payments")),
                    )
                  : MultiSliver(
                      children: [
                        _getTitleWidget("Overdue payments"),
                        _getOverduePaymentsWidget(clientService, loanStatementService),
                        _getTitleWidget("Recent payments"),
                        _getRecentlyPaidPaymentsWidget(clientService, loanStatementService, paymentService)
                      ],
                    )
            ],
          );
        },
      ),
    );
  }

  Widget _getTitleWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: HeaderFourText(
        text: text,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  SliverList _getOverduePaymentsWidget(
      ClientService clientService, LoanStatementService loanStatementService) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var loneStatement =
              loanStatementService.getOverdueLoanStatements()[index];
          var client = clientService.getClientById(loneStatement.clientId);

          return PaymentListCard(client: client, loanStatement: loneStatement);
        },
        childCount: loanStatementService.getOverdueLoanStatements().length,
      ),
    );
  }

  SliverList _getRecentlyPaidPaymentsWidget(
      ClientService clientService,
      LoanStatementService loanStatementService,
      PaymentService paymentService) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var payment = paymentService.getRecentlyPaidPayments()[index];
          var loneStatement = loanStatementService
              .getLoanStatementById(payment.loanStatementId);
          var client = clientService.getClientById(payment.clientId);

          return PaymentListCard(client: client, loanStatement: loneStatement);
        },
        childCount: paymentService.getRecentlyPaidPayments().length,
      ),
    );
  }
}
