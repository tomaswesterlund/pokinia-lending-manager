import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/client.dart';
import 'package:pokinia_lending_manager/models/data/loan_statement.dart';

class PaymentListCard extends StatelessWidget {
  final Client client;
  final LoanStatement loanStatement;
  const PaymentListCard(
      {super.key, required this.client, required this.loanStatement});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
    // return GestureDetector(
    //   onTap: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) =>
    //             LoanStatementPage(loanStatementId: loanStatement.id),
    //       ),
    //     );
    //   },
    //   child: Container(
    //     margin: const EdgeInsets.all(10),
    //     padding: const EdgeInsets.all(10),
    //     // height: 50,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //       color: const Color(0xFFF8F8F8),
    //       border: Border(
    //         bottom: BorderSide(
    //           color: Colors.grey[300]!,
    //         ),
    //       ),
    //     ),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         MyAvatarComponent(client: client),
    //         const SizedBox(width: 15),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 DotPaymentStatus(
    //                     paymentStatus: loanStatement.paymentStatus),
    //                 const SizedBox(width: 10),
    //                 ParagraphOneText(
    //                     text: client.name,
    //                     fillColor: const Color(0xFF1D2424),
    //                     fontWeight: FontWeight.bold)
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 const ParagraphTwoText(
    //                     text: "Date", fillColor: Color(0xff9EA6A7)),
    //                 const SizedBox(width: 10),
    //                 ParagraphTwoText(
    //                     text: loanStatement.expectedPayDate.toFormattedDate()),
    //               ],
    //             ),
    //           ],
    //         ),
    //         Expanded(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 children: [
    //                   const ParagraphTwoText(
    //                       text: "Amount", fillColor: Color(0xff9EA6A7)),
    //                   BigAmountText(
    //                       text: loanStatement.remainingAmountToBePaid
    //                           .toFormattedCurrency()),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    
  }
}
