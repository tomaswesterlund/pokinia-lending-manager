import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/loans/loan_user_status_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/compact_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text_with_title_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/pages/loan_statements/loan_statement_page.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class OpenEndedLoanPage extends StatelessWidget {
  final Loan loan;
  const OpenEndedLoanPage({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Open ended loan'),
      // ),
      body: Consumer4<ClientService, LoanService, LoanStatementService,
          PaymentService>(
        builder: (context, clientService, loanService, loanStatementService,
            paymentService, _) {
          var openEndedLoan = loanService.getOpenEndedLoanByLoanId(loan.id);
          var loanStatements =
              loanStatementService.getLoanStatementsByLoanId(loan.id);
          var client = clientService.getClientById(loan.clientId);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 50.0,
                title: const Text("Open ended loan"),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    tooltip: 'Add new entry',
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
              SliverToBoxAdapter(
                  child: LoanUserStatus(client: client, loan: loan)),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const ParagraphOneText(
                      text: 'Remaining principal amount',
                      fontWeight: FontWeight.bold,
                    ),
                    PrimaryAmountText(
                        text: openEndedLoan.remainingPrincipalAmount
                            .toFormattedCurrency())
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    BigAmountTextWithTitleText.withAmount(
                        title: 'Initial principal amount',
                        amount: openEndedLoan.initialPrincipalAmount),
                    BigAmountTextWithTitleText.withAmount(
                        title: 'Principal amount paid',
                        amount: openEndedLoan.principalAmountPaid),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    BigAmountTextWithTitleText.withAmount(
                        title: 'Interest amount paid',
                        amount: openEndedLoan.interestAmountPaid),
                    BigAmountTextWithTitleText.withPercentage(
                        title: 'Interest rate',
                        percentage: openEndedLoan.interestRate),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const ParagraphOneText(
                            text: 'Start date',
                            fontWeight: FontWeight.bold,
                          ),
                          ParagraphOneText(
                              text: openEndedLoan.startDate.toFormattedDate()),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const ParagraphOneText(
                                  text: 'Status',
                                  fontWeight: FontWeight.bold,
                                ),
                                Row(
                                  children: [
                                    DotPaymentStatus(
                                        paymentStatus: loan.paymentStatus),
                                    const SizedBox(width: 8),
                                    ParagraphOneText(
                                        text: loan.paymentStatus.name)
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
              const SliverToBoxAdapter(child: Center(child: HeaderFourText(text: 'Loan Statements'))),
              SliverList.builder(
                itemCount: loanStatements.length,
                itemBuilder: (context, index) {
                  var loanStatement = loanStatements[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoanStatementPage(
                              loanStatementId: loanStatement.id),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      // height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFF8F8F8),
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[300]!,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CompactPaymentStatusBox(
                                  paymentStatus: loanStatement.paymentStatus),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const ParagraphTwoText(text: 'Pay date'),
                                      SmallAmountText.withText(
                                          text: loanStatement.expectedPayDate
                                              .toFormattedDate()),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const ParagraphTwoText(
                                          text: 'Principal (paid/expected)'),
                                      SmallAmountText.withText(
                                          text:
                                              '${loanStatement.principalAmountPaid.toFormattedCurrency()} / ${loanStatement.expectedPrincipalAmount.toFormattedCurrency()}'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const ParagraphTwoText(
                                          text: 'Interests (paid/expected)'),
                                      SmallAmountText.withText(
                                          text:
                                              '${loanStatement.interestAmountPaid.toFormattedCurrency()} / ${loanStatement.expectedInterestAmount.toFormattedCurrency()}'),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
            ],
          );
        },
      ),
    );
  }
}
