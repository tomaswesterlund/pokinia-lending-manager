import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/payments/add_payment_modal_component.dart';
import 'package:pokinia_lending_manager/components/payments/payment_table_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_five_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/pages/clients/new_client_page.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class LoanStatementPage extends StatefulWidget {
  final String loanStatementId;
  const LoanStatementPage({super.key, required this.loanStatementId});

  @override
  State<LoanStatementPage> createState() => _LoanStatementPageState();
}

class _LoanStatementPageState extends State<LoanStatementPage> {
  @override
  Widget build(BuildContext context) {
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
        body: Consumer<LoanStatementService>(
          builder: (context, loanStatementService, _) {
            var loanStatement = loanStatementService
                .getLoanStatementById(widget.loanStatementId);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const HeaderFourText(
                              text: 'Remaining amount to be paid'),
                          PrimaryAmountText(
                              text: loanStatement.remainingAmountToBePaid
                                  .toFormattedCurrency())
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const HeaderFiveText(
                              text: "Payment status",
                              fontWeight: FontWeight.normal),
                          Row(
                            children: [
                              DotPaymentStatus(
                                  paymentStatus: loanStatement.paymentStatus),
                              const SizedBox(width: 5),
                              ParagraphTwoText(
                                  text: loanStatement.paymentStatus.name),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const HeaderFiveText(
                              text: "Interest paid / expected",
                              fontWeight: FontWeight.normal),
                          SmallAmountText(
                              text:
                                  "${loanStatement.interestAmountPaid.toFormattedCurrency()} / ${loanStatement.expectedInterestAmount.toFormattedCurrency()}")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const HeaderFiveText(
                              text: "Principal paid / expected",
                              fontWeight: FontWeight.normal),
                          SmallAmountText(
                              text:
                                  "${loanStatement.principalAmountPaid.toFormattedCurrency()} / ${loanStatement.expectedPrincipalAmount.toFormattedCurrency()}")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const HeaderFiveText(
                              text: "Interest rate",
                              fontWeight: FontWeight.normal),
                          SmallAmountText(
                              text: "${loanStatement.interestRate}%")
                        ],
                      ),
                    ],
                  ),
                ),
                const HeaderFiveText(text: "Payments"),
                PaymentTable(loanStatementId: loanStatement.id),
                AddPaymentModal(loanStatement: loanStatement)
              ],
            );
          },
        ));
  }
}
