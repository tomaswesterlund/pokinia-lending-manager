import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/fabs.dart';
import 'package:pokinia_lending_manager/components/loans/loan_user_status_component.dart';
import 'package:pokinia_lending_manager/components/payments/small_payment_list_card.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/models/loan.dart';
import 'package:pokinia_lending_manager/pages/payments/new_payment_page.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class ZeroInterestLoanPage extends StatelessWidget {
  final Loan loan;
  const ZeroInterestLoanPage({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zero Interest Loan'),
      ),
      body: Consumer3<ClientService, LoanService, PaymentService>(
        builder: (context, clientService, loanService, paymentService, _) {
          var zeroInterestLoan =
              loanService.getZeroInterestLoanByLoanId(loan.id);
          var client = clientService.getClientById(loan.clientId);
          var payments =
              paymentService.getPaymentsByLoanId(zeroInterestLoan.loanId);

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                LoanUserStatus(client: client, loan: loan),
                const SizedBox(height: 24),
                Column(
                  children: [
                    const ParagraphOneText(
                      text: 'Remaining amount',
                      fontWeight: FontWeight.bold,
                    ),
                    PrimaryAmountText(
                        text: zeroInterestLoan.remainingPrincipalAmount
                            .toFormattedCurrency())
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ParagraphOneText(
                        text: 'Initial principal amount:',
                        fontWeight: FontWeight.bold,
                      ),
                      ParagraphOneText(
                          text: zeroInterestLoan.initialPrincipalAmount
                              .toFormattedCurrency())
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ParagraphOneText(
                        text: 'Expected pay date',
                        fontWeight: FontWeight.bold,
                      ),
                      zeroInterestLoan.expectedPayDate != null
                          ? ParagraphOneText(
                              text: zeroInterestLoan.expectedPayDate!
                                  .toFormattedDate())
                          : const ParagraphOneText(text: "None")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ParagraphOneText(
                        text: 'Status',
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          DotPaymentStatus(paymentStatus: loan.paymentStatus),
                          const SizedBox(width: 8),
                          ParagraphOneText(text: loan.paymentStatus.name)
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                const HeaderFourText(text: "Payments"),
                const SizedBox(height: 8),
                Flexible(
                  child: ListView.builder(
                      itemCount: payments.length,
                      itemBuilder: (context, index) {
                        var payment = payments[index];
                        return SmallPaymentListCard(
                            payment: payment, showInterests: false);
                      }),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: getDefaultFab(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewPaymentPage(loan: loan)))),
    );
  }
}
