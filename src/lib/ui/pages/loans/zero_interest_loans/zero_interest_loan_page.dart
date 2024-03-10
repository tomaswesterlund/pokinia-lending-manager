import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/zero_interest_loan_provider.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/ui/components/buttons/fabs.dart';
import 'package:pokinia_lending_manager/ui/components/loans/loan_user_status_component.dart';
import 'package:pokinia_lending_manager/ui/components/payments/small_payment_list_card.dart';
import 'package:pokinia_lending_manager/ui/components/status_boxes/payment_status/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/ui/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/ui/pages/payments/new_payment_page.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class ZeroInterestLoanPage extends StatelessWidget {
  final String loanId;
  const ZeroInterestLoanPage({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    var clientProvider = Provider.of<ClientProvider>(context);
    var loanProvider = Provider.of<LoanProvider>(context);
    var paymentProvider = Provider.of<PaymentProvider>(context);

    return Consumer<ZeroInterestLoanProvider>(builder: (context, provider, _) {
      var zeroInterestLoan = provider.getByLoanId(loanId);
      var loan = loanProvider.getById(loanId);
      var client = clientProvider.getById(loan.clientId);
      var payments = paymentProvider.getByLoanId(loanId);
      

      return Scaffold(
        appBar: AppBar(
          title: const Text('Zero Interest Loan'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              LoanUserStatus(client: client, loan: loan),
              const SizedBox(height: 24),
              Column(
                children: [
                  const ParagraphOneText(
                    text: 'Remaining principal amount',
                    fontWeight: FontWeight.bold,
                  ),
                  PrimaryAmountText(
                      text: zeroInterestLoan.principalAmountRemaining
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: getDefaultFab(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewPaymentPage(loan: loan)))),
      );
    });
  }
}
