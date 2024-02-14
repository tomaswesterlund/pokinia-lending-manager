import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/payments/payment_list_card_component.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/pages/clients/new_client_page.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:provider/provider.dart';

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
              SliverAppBar(
                title: const HeaderTwoText(text: "Payments"),
                scrolledUnderElevation: 0,
                floating: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      showMaterialModalBottomSheet(
                        enableDrag: false,
                        isDismissible: false,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                        ),
                        context: context,
                        builder: (context) => const NewClientPage(),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 28.0,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              SliverToBoxAdapter(child: _getTitleWidget("Overdue payments")),
              _getOverduePayments(clientService, loanStatementService),
              SliverToBoxAdapter(child: _getTitleWidget("Recent payments")),
              _getRecentlyPaidPayments(
                  clientService, loanStatementService, paymentService),
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

  SliverList _getOverduePayments(
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

  SliverList _getRecentlyPaidPayments(
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
