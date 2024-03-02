import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/dot_payment_status_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/models/client.dart';
import 'package:pokinia_lending_manager/models/loan_statement.dart';
import 'package:pokinia_lending_manager/models/payment.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';

class RecentPaymentListCard extends StatelessWidget {
  final Client client;
  final LoanStatement loanStatement;
  final Payment payment;

  const RecentPaymentListCard({
    super.key,
    required this.client,
    required this.loanStatement,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  DotPaymentStatus(paymentStatus: loanStatement.paymentStatus),
                  const SizedBox(width: 10),
                  ParagraphOneText(
                      text: client.name,
                      fillColor: const Color(0xFF1D2424),
                      fontWeight: FontWeight.bold)
                ],
              ),
              Row(
                children: [
                  const ParagraphTwoText(
                      text: "Fecha", fillColor: Color(0xff9EA6A7)),
                  const SizedBox(width: 10),
                  ParagraphTwoText(
                      text: payment.payDate.toFormattedDate()),
                ],
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const ParagraphTwoText(
                        text: "Amount", fillColor: Color(0xff9EA6A7)),
                    BigAmountText(
                        text: (payment.interestAmountPaid + payment.principalAmountPaid)
                            .toFormattedCurrency()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
