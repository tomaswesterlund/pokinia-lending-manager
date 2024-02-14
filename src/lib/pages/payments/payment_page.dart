import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_red_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/red_paragraph_one_regular_text.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
  final String paymentId;
  const PaymentPage({super.key, required this.paymentId});

  @override
  Widget build(BuildContext context) {
    final PaymentService paymentService =
        Provider.of<PaymentService>(context, listen: false);

    void delete() {
      paymentService.deletePayment(paymentId);
      // Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment page"),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: "edit",
                child: Text("Edit"),
              ),
              const PopupMenuItem(
                value: "delete",
                child: Text("Delete"),
              )
            ];
          }, onSelected: (value) {
            if (value == "delete") {
              delete();
            }
          })
        ],
      ),
      body: Consumer<PaymentService>(
        builder: (context, paymentService, _) {
          var payment = paymentService.getPaymentById(paymentId);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        if (payment.deleted)
                          Column(
                            children: [
                              const RedParagraphOneRegularText(
                                  text: "Payment deleted"),
                              PrimaryAmountRedText(
                                  text: (payment.interestAmountPaid +
                                          payment.principalAmountPaid)
                                      .toFormattedCurrency())
                            ],
                          )
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
              if (payment.deleteDate != null)
                Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Column(
                            children: [
                              const RedParagraphOneRegularText(
                                  text: "Delete date"),
                              SmallAmountText(
                                  text: payment.deleted
                                      ? payment.deleteDate!.toFormattedDate()
                                      : "N/A")
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
                              const RedParagraphOneRegularText(
                                  text: "Delete reason"),
                              SmallAmountText(
                                  text: payment.deleteReason == null
                                      ? "N/A"
                                      : payment.deleteReason!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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
          );
        },
      ),
    );
  }
}
