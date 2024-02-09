import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/payments/payment_table_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/components/texts/percentages/small_percentage_text.dart';
import 'package:pokinia_lending_manager/models/loan_statement_model.dart';
import 'package:pokinia_lending_manager/pages/clients/new_client_page.dart';
import 'package:pokinia_lending_manager/pages/payments/new_payment_page.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class LoanStatementPage extends StatefulWidget {
  final String paymentId;
  const LoanStatementPage({super.key, required this.paymentId});

  @override
  State<LoanStatementPage> createState() => _LoanStatementPageState();
}

class _LoanStatementPageState extends State<LoanStatementPage> {
  @override
  Widget build(BuildContext context) {
    var loanStatementService =
        Provider.of<LoanStatementService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Loan Statement"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewClientPage(),
              ),
            ),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: StreamBuilder<Object>(
          stream:
              loanStatementService.getLoanStatementByIdStream(widget.paymentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var loanStatement = snapshot.data as LoanStatementModel;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                             const ParagraphOneText(
                                text: 'Remaining amount to be paid'),
                            PrimaryAmountText(
                                text: loanStatement.remainingAmountToBePaid
                                    .toFormattedCurrency())
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                             const ParagraphOneText(
                                text: "Expected interest"),
                            SmallAmountText(
                                text: loanStatement.expectedInterestAmount
                                    .toFormattedCurrency()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                             const ParagraphOneText(
                                text: "Expected principal"),
                            SmallAmountText(
                                text: loanStatement.expectedPrincipalAmount
                                    .toFormattedCurrency()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                             const ParagraphOneText(
                                text: "Interest paid"),
                            SmallAmountText(
                                text: loanStatement.interestAmountPaid
                                    .toFormattedCurrency()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                             const ParagraphOneText(
                                text: "Principal paid"),
                            SmallAmountText(
                                text: loanStatement.principalAmountPaid
                                    .toFormattedCurrency()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                             const ParagraphOneText(
                                text: "Expected pay date"),
                            ParagraphTwoText(
                                text: loanStatement.expectedPayDate
                                    .toFormattedDate()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                             const ParagraphOneText(text: "Status"),
                            ParagraphTwoText(
                                text: loanStatement.paymentStatus.name),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                             const ParagraphOneText(
                                text: "Interest rate"),
                            SmallPercentageText(
                                percentage: loanStatement.interestRate),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                             const ParagraphOneText(
                                text: "Interest paid"),
                            SmallAmountText(
                                text: loanStatement.interestAmountPaid
                                    .toFormattedCurrency()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text("Payments"),
                  PaymentTable(loanStatementId: loanStatement.id),
                  Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: Column(
                      children: [
                        MyCtaButton(
                            text: "Add payment",
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewPaymentPage(
                                        clientId: loanStatement.clientId,
                                        loanId: loanStatement.loanId,
                                        loanStatementId: loanStatement.id)))),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
