import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/ui/components/alerts/deleted_alert.dart';
import 'package:pokinia_lending_manager/ui/components/payments/app_bars/payment_app_bar.dart';
import 'package:pokinia_lending_manager/ui/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
  final String paymentId;

  const PaymentPage({super.key, required this.paymentId});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, paymentService, _) {
        var payment = paymentService.getById(paymentId);

        return Scaffold(
          appBar: PaymentAppBar(paymentId: paymentId),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        if (payment.deleted)
                          DeletedAlert(
                              title: 'This payment has been deleted!',
                              deleteDate: payment.deleteDate,
                              deleteReason: payment.deleteReason)
                        else
                          Column(
                            children: [
                              const ParagraphOneText(text: 'Total amount paid'),
                              PrimaryAmountText(
                                  text: (payment.interestAmountPaid +
                                          payment.principalAmountPaid)
                                      .toFormattedCurrency())
                            ],
                          )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 200,
                            child: Column(
                              children: [
                                const ParagraphOneText(text: "Interest paid"),
                                SmallAmountText(
                                    text: payment.interestAmountPaid
                                        .toFormattedCurrency()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 200,
                            child: Column(
                              children: [
                                const ParagraphOneText(text: "Principal paid"),
                                SmallAmountText(
                                    text: payment.principalAmountPaid
                                        .toFormattedCurrency()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  payment.receiptImagePath.isNullOrEmpty()
                      ? const ParagraphOneText(text: "No receipt uploaded")
                      : Column(
                          children: [
                            const ParagraphOneText(text: "Receipt"),
                            Image.network(
                              payment.receiptImagePath,
                              width: 200,
                              height: 200,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
