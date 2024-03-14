import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/boxes/deleted_alert_box.dart';
import 'package:pokinia_lending_manager/components/buttons/fabs.dart';
import 'package:pokinia_lending_manager/components/loan_statements/loan_statement_app_bar.dart';
import 'package:pokinia_lending_manager/components/payments/empty_payment_list_component.dart';
import 'package:pokinia_lending_manager/components/payments/small_payment_list_card.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/wide_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text_with_title_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_five_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/data/loan_statement.dart';
import 'package:pokinia_lending_manager/pages/payments/new_payment_page.dart';
import 'package:pokinia_lending_manager/providers/loan_statement_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class LoanStatementPage extends StatefulWidget {
  final String loanStatementId;
  const LoanStatementPage({super.key, required this.loanStatementId});

  @override
  State<LoanStatementPage> createState() => _LoanStatementPageState();
}

class _LoanStatementPageState extends State<LoanStatementPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<LoanProvider, LoanStatementProvider, PaymentProvider>(
      builder:
          (context, loanProvider, loanStatementProvider, paymentProvider, _) {
        var loanStatement =
            loanStatementProvider.getById(widget.loanStatementId);
        var loan = loanProvider.getById(loanStatement.loanId);
        var payments =
            paymentProvider.getByLoanStatementId(widget.loanStatementId);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              LoanStatementAppBar(loanStatementId: widget.loanStatementId),
              MultiSliver(
                children: [
                  Column(
                    children: [
                      _getDeletedWidget(loanStatement),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const ParagraphTwoText(text: "Status"),
                                const Spacer(),
                                WidePaymentStatusBoxComponent(
                                    paymentStatus: loanStatement.paymentStatus)
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const ParagraphTwoText(
                                    text: "Expected pay date"),
                                const Spacer(),
                                ParagraphTwoText(
                                    text: loanStatement.expectedPayDate
                                        .toFormattedDate()),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _getRemainingAmountWidget(loanStatement),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BigAmountTextWithTitleText.withAmount(
                                title: 'Principal paid',
                                amount: loanStatement.principalAmountPaid),
                            BigAmountTextWithTitleText.withAmount(
                                title: 'Principal expected',
                                amount: loanStatement.expectedPrincipalAmount),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BigAmountTextWithTitleText.withAmount(
                                title: 'Interest paid',
                                amount: loanStatement.interestAmountPaid),
                            BigAmountTextWithTitleText.withAmount(
                                title: 'Interest expected',
                                amount: loanStatement.expectedInterestAmount),
                          ],
                        ),
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BigAmountTextWithTitleText.withPercentage(
                              title: 'Interest rate',
                              percentage: loanStatement.interestRate),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Center(
                    child: HeaderThreeText(text: "Payments"),
                  ),
                  payments.isEmpty
                      ? const EmptyPaymentList()
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final payment = payments[index];
                              return SmallPaymentListCard(payment: payment);
                            },
                            childCount: payments.length,
                          ),
                        ),
                  const SizedBox(height: 128),
                ],
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: getDefaultFab(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NewPaymentPage(
                      loan: loan, loanStatement: loanStatement);
                }),
              );
            },
          ),
        );
      },
    );
  }

  Widget _getDeletedWidget(LoanStatement loanStatement) {
    if (loanStatement.paymentStatus == PaymentStatus.deleted) {
      return DeletedAlertBox(
          title: 'Loan statement has been deleted!',
          deleteDate: loanStatement.deleteDate,
          deleteReason: loanStatement.deleteReason);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _getRemainingAmountWidget(LoanStatement loanStatement) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const HeaderFourText(text: 'Remaining amount to be paid'),
              PrimaryAmountText(
                  text: loanStatement.remainingAmountToBePaid
                      .toFormattedCurrency())
            ],
          )
        ],
      ),
    );
  }

  Widget _getInfoRowsWidget(LoanStatement loanStatement) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Column(
        children: [
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
                  text: "Interest rate", fontWeight: FontWeight.normal),
              SmallAmountText(text: "${loanStatement.interestRate}%")
            ],
          ),
        ],
      ),
    );
  }
}
