import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cancel_button.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/small_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_regular_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_regular_text.dart';
import 'package:pokinia_lending_manager/components/texts/percentages/small_percentage_text.dart';
import 'package:pokinia_lending_manager/models/payment_model.dart';
import 'package:pokinia_lending_manager/pages/clients/new_client_page.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final String paymentId;
  const PaymentPage({super.key, required this.paymentId});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  DateFormat dateFormat = DateFormat("MMM-dd");
  bool isEditMode = false;

  final TextEditingController _principalPaymentController =
      TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _interestPaymentController =
      TextEditingController();

  void _toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  void _saveChanges() {
    // setState(() {
    //   var paymentProvider =
    //       Provider.of<PaymentProvider>(context, listen: false);
    //var payment = paymentProvider.getPaymentById(widget.paymentId);

    // payment.principalPayment = double.parse(_principalPaymentController.text);
    // payment.interestRate = double.parse(_interestRateController.text);
    // payment.interestPayment = double.parse(_interestPaymentController.text);

    //paymentProvider.updatePayment(payment);

    //   isEditMode = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    var paymentService = Provider.of<PaymentService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewClientPage(),
              ),
            ),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: StreamBuilder<Object>(
          stream: paymentService.getPaymentByIdStream(widget.paymentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var payment = snapshot.data as PaymentModel;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const ParagraphOneRegularText(
                                text: 'Remaining amount to be paid'),
                            PrimaryAmountText(amount: payment.totalRemainingAmountToBePaid)
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 200,
                            child: Column(
                              children: [
                                const ParagraphOneRegularText(
                                    text: "Interest paid"),
                                if (isEditMode)
                                  MyTextField(
                                      labelText: "Interest paid",
                                      controller: _principalPaymentController)
                                else
                                  SmallAmountText(
                                      amount: payment.interestAmountPaid),
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
                                const ParagraphOneRegularText(
                                    text: "Principal paid"),
                                if (isEditMode)
                                  MyTextField(
                                      labelText: "Principal paid",
                                      controller: _principalPaymentController)
                                else
                                  SmallAmountText(
                                      amount: payment.principalAmountPaid),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const ParagraphOneRegularText(
                              text: "Expected pay date"),
                          ParagraphTwoRegularText(
                              text: payment.expectedPayDate.toString()),
                        ],
                      ),
                       Column(
                        children: [
                          const ParagraphOneRegularText(text: "Actual pay date"),
                          ParagraphTwoRegularText(text: payment.actualPayDate == null ? "-" : payment.actualPayDate!.toString()) ,
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Column(
                          children: [
                            const ParagraphOneRegularText(
                                text: "Interest rate"),
                            if (isEditMode)
                              MyTextField(
                                  labelText: "Interest rate",
                                  controller: _interestRateController)
                            else
                              SmallPercentageText(percentage: payment.interestRate),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Column(
                          children: [
                            const ParagraphOneRegularText(
                                text: "Interest paid"),
                            if (isEditMode)
                              MyTextField(
                                  labelText: "Interest paid",
                                  controller: _interestPaymentController)
                            else
                              SmallAmountText(amount: payment.interestAmountPaid),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text("Receipts"),
                  // Expanded(
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: receipts.length,
                  //     itemBuilder: (context, index) {
                  //       var receipt = receipts[index];

                  //       return GestureDetector(
                  //         onTap: () => Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) =>
                  //                   ReceiptPage(receiptId: receipt.id)),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  //           child: Container(
                  //             color: index % 2 == 0
                  //                 ? const Color(0xFFF4FDFD)
                  //                 : Colors.white,
                  //             child: Padding(
                  //               padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //                 children: [
                  //                   ParagraphTwoRegularText(
                  //                       text: dateFormat.format(receipt.date)),
                  //                   SmallAmountText(
                  //                       text: receipt.interestPayment
                  //                           .toFormattedCurrency()),
                  //                   const Icon(Icons.arrow_forward_ios, size: 12.0)
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  isEditMode
                      ? Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: Column(
                            children: [
                              MyCtaButton(
                                  text: "Save", onPressed: _saveChanges),
                              const MyCancelButton(
                                  text: "Cancel", onPressed: null)
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: MyCtaButton(
                              text: "Edit", onPressed: _toggleEditMode),
                        ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
