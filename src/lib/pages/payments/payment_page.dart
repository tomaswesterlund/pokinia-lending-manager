import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_red_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/red_paragraph_one_regular_text.dart';
import 'package:pokinia_lending_manager/models/payment.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final String paymentId;
  const PaymentPage({super.key, required this.paymentId});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final Logger _logger = getLogger('PaymentPage');

  void _deletePayment(PaymentService paymentService) {
    _logger.i('_deletePayment - id: ${widget.paymentId}');
    // Are you sure you want to delete?

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete payment'),
          content: const Text('Are you sure you want to delete this payment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Add your deletion logic here
                var response = await paymentService.deletePayment(
                    widget.paymentId, 'Deleted by user from payment page');

                if (response.succeeded) {
                  Navigator.of(context).pop();
                } else {
                  Fluttertoast.showToast(
                      msg: response.body!,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentService>(
      builder: (context, paymentService, _) {
        var payment = paymentService.getPaymentById(widget.paymentId);

        return Scaffold(
          appBar: _getAppBar(paymentService, payment),
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
          ),
        );
      },
    );
  }

  AppBar _getAppBar(PaymentService paymentService, Payment payment) {
    return AppBar(
      title: const Text("Payment page"),
      actions: [
        PopupMenuButton<int>(
          onSelected: (value) async {
            if (value == 1) {
              _deletePayment(paymentService);
            }
            if (value == 2) {
              await paymentService.undeletePayment(widget.paymentId);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 0,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 12.0),
                      Text(
                        "Edit payment",
                      )
                    ],
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<int>(
              value: 1,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        "Delete payment",
                      )
                    ],
                  ),
                ],
              ),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        "Un-delete payment",
                      )
                    ],
                  ),
                ],
              ),
            ), const PopupMenuItem<int>(
              value: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        "Delete forever",
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
