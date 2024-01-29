import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/primary_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_regular_text.dart';
import 'package:pokinia_lending_manager/providers/receipt_provider.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class ReceiptPage extends StatelessWidget {
  final String receiptId;
  const ReceiptPage({super.key, required this.receiptId});

  @override
  Widget build(BuildContext context) {
    return const Text("ReceiptPage");
    // return Consumer<ReceiptProvider>(
    //   builder: (context, receiptProvider, child) {
    //     var receipt = receiptProvider.getReceiptById(receiptId);

    //     return Scaffold(
    //       appBar: AppBar(
    //         title: const Text("Transaction"),
    //       ),
    //       body: Center(
    //         child: Column(
    //           children: [
    //             const Text("Date"),
    //             const Text("Amount"),
    //             const Text("Comprobante"),

    //             Padding(
    //               padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Column(
    //                     children: [
    //                       const ParagraphOneRegularText(
    //                           text: 'Total amount paid'),
    //                       PrimaryAmountText(
    //                         text: receipt.totalAmountPaid.toFormattedCurrency(),
    //                       )
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             ),
    //             // Row -> Avatar, Name and Status
    //             Padding(
    //               padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Column(
    //                     children: [
    //                       const ParagraphOneRegularText(text: 'Interest paid'),
    //                       BigAmountText(amount: receipt.interestPayment),
    //                     ],
    //                   ),
    //                   Column(
    //                     children: [
    //                       const ParagraphOneRegularText(text: 'Principal paid'),
    //                       BigAmountText(amount: receipt.principalPayment),
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             ),

    //             const SizedBox(height: 100),

    //             const SizedBox(height: 25),

    //             const Text("No transactions were found."),
    //             const Text("Would you like to create a new transaction?"),

    //             const SizedBox(height: 100),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
