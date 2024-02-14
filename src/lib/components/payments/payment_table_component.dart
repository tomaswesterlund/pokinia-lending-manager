import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/pages/payments/payment_page.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class PaymentTable extends StatelessWidget {
  final String loanStatementId;
  const PaymentTable({super.key, required this.loanStatementId});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentService>(builder: (context, paymentService, _) {
      var payments =
          paymentService.getPaymentsByLoanStatementId(loanStatementId);

      return ListView.builder(
        shrinkWrap: true,
        itemCount: payments.length,
        itemBuilder: (context, index) {
          var payment = payments[index];

          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentPage(paymentId: payment.id),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                color: index % 2 == 0 ? const Color(0xFFF4FDFD) : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (payment.deleted)
                        const Icon(Icons.delete, color: Colors.red)
                      else
                        const Icon(Icons.money),
                      Expanded(
                        child: ParagraphTwoText(
                            text: payment.date.toFormattedDate()),
                      ),
                      Expanded(
                        child: SmallAmountText(
                            text: payment.interestAmountPaid
                                .toFormattedCurrency()),
                      ),
                      Expanded(
                        child: SmallAmountText(
                            text: payment.principalAmountPaid
                                .toFormattedCurrency()),
                      ),
                      const Expanded(
                          child: Icon(Icons.arrow_forward_ios, size: 12.0))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
