import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/compact_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_bold_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_regular_text.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/models/loan_model.dart';
import 'package:pokinia_lending_manager/pages/loans/loan_page.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';

class LoanListCard extends StatelessWidget {
  final ClientModel client;
  final LoanModel loan;

  const LoanListCard({super.key, required this.client, required this.loan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LoanPage(clientId: client.id, loanId: loan.id),
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
            Image.asset(
              "assets/images/dummy_avatar.png",
              width: 48,
              height: 48,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DotPaymentStatus(paymentStatus: loan.paymentStatus),
                    const SizedBox(width: 5),
                    ParagraphOneBoldText(text: client.name),
                  ],
                ),
                Row(
                  children: [
                    const ParagraphTwoRegularText(
                        text: "Interest: ", color: Color(0xFF9EA6A7)),
                    ParagraphTwoRegularText(
                        text: "${loan.initialInterestRate}% ",
                        color: const Color(0xFF1C2829)),
                    const ParagraphTwoRegularText(
                        text: "| ", color: Color(0xFF9EA6A7)),
                    const ParagraphTwoRegularText(
                        text: "Monthly", color: Color(0xFF1C2829)),
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
                      const ParagraphTwoRegularText(text: "Remaining"),
                      BigAmountText(
                          text: loan.remainingPrincipalAmount
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
