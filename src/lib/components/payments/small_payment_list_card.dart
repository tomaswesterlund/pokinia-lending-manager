import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/models/payment.dart';
import 'package:pokinia_lending_manager/pages/payments/payment_page.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';

class SmallPaymentListCard extends StatelessWidget {
  final Payment payment;
  final bool showInterests;
  const SmallPaymentListCard(
      {super.key, required this.payment, this.showInterests = true});

  @override
  Widget build(BuildContext context) {
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
                        SmallAmountText(
                            text: payment.payDate.toFormattedDate()),
                      ],
                    ),
                    const SizedBox(width: 16),
                    if (showInterests)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ParagraphTwoText(
                              text: "Interest paid",
                              fontWeight: FontWeight.bold),
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
