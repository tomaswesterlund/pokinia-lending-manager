import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/buttons/fabs.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_five_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/models/payment.dart';
import 'package:pokinia_lending_manager/pages/clients/new_client_page.dart';
import 'package:pokinia_lending_manager/pages/payments/new_payment_page.dart';
import 'package:pokinia_lending_manager/pages/payments/payment_page.dart';
import 'package:pokinia_lending_manager/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
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
    return Consumer2<LoanStatementService, PaymentService>(
      builder: (context, loanStatementService, paymentService, _) {
        var loanStatement =
            loanStatementService.getLoanStatementById(widget.loanStatementId);

        var payments =
            paymentService.getPaymentsByLoanStatementId(widget.loanStatementId);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
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
              MultiSliver(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 32.0),
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
                                        paymentStatus:
                                            loanStatement.paymentStatus),
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
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Center(
                    child: HeaderFourText(text: "Payments"),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final payment = payments[index];
                        return _paymentListCard(context, payment);
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
            onPressed: () => showMaterialModalBottomSheet(
              enableDrag: true,
              isDismissible: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              context: context,
              builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: NewPaymentPage(
                      clientId: loanStatement.clientId,
                      loanId: loanStatement.loanId,
                      loanStatementId: loanStatement.id)),
            ),
          ),
        );
      },
    );
  }

  Widget _paymentListCard(BuildContext context, Payment payment) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(paymentId: payment.id),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFF8F8F8),
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300]!,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (payment.deleted)
                          const Icon(Icons.delete, color: Colors.red)
                        else
                          const Icon(Icons.money)
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ParagraphTwoText(
                            text: "Date", fontWeight: FontWeight.bold),
                        SmallAmountText(text: payment.payDate.toFormattedDate()),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ParagraphTwoText(
                            text: "Interest paid", fontWeight: FontWeight.bold),
                        SmallAmountText(
                            text: payment.interestAmountPaid
                                .toFormattedCurrency()),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ParagraphTwoText(
                            text: "Principal paid",
                            fontWeight: FontWeight.bold),
                        SmallAmountText(
                            text: payment.principalAmountPaid
                                .toFormattedCurrency()),
                      ],
                    ),
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.arrow_forward_ios),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
