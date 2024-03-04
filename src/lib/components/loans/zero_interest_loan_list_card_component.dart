import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/models/data/client.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/models/data/loans/zero_interest_loan.dart';
import 'package:pokinia_lending_manager/pages/loans/loan_page.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';

class ZeroInterestLoanListCard extends StatelessWidget {
  final Client client;
  final Loan loan;
  final ZeroInterestLoan zeroInterestLoan;

  const ZeroInterestLoanListCard(
      {super.key,
      required this.client,
      required this.loan,
      required this.zeroInterestLoan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoanPage(loan: loan),
            ));
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
            MyAvatarComponent(client: client),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DotPaymentStatus(paymentStatus: loan.paymentStatus),
                    const SizedBox(width: 5),
                    ParagraphOneText(
                        text: client.name, fontWeight: FontWeight.bold),
                  ],
                ),
                const Row(
                  children: [
                    ParagraphTwoText(
                        text: "Type: ",
                        fillColor: Color(0xFF9EA6A7)),
                    ParagraphTwoText(text: "Zero interest loan", fillColor: Color(0xFF1C2829)),
                  ],
                ),
                Row(
                  children: [
                    const ParagraphTwoText(
                        text: "Expected pay date: ",
                        fillColor: Color(0xFF9EA6A7)),
                    ParagraphTwoText(
                        text: zeroInterestLoan.expectedPayDate != null
                            ? zeroInterestLoan.expectedPayDate!
                                .toFormattedDate()
                            : "N/A",
                        fillColor: const Color(0xFF1C2829)),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ParagraphTwoText(text: "Remaining"),
                      BigAmountText(
                          text: zeroInterestLoan.principalAmountPaid
                              .toFormattedCurrency())
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
