// import 'package:flutter/material.dart';
// import 'package:pokinia_lending_manager/models/data/client.dart';
// import 'package:pokinia_lending_manager/models/data/loan.dart';
// import 'package:pokinia_lending_manager/ui/components/avatars/my_avatar_component.dart';
// import 'package:pokinia_lending_manager/ui/components/status_boxes/payment_status/dot_payment_status_component.dart';
// import 'package:pokinia_lending_manager/ui/components/texts/amounts/big_amount_text.dart';
// import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_one_text.dart';
// import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_two_text.dart';
// import 'package:pokinia_lending_manager/ui/pages/loans/loan_page.dart';
// import 'package:pokinia_lending_manager/util/double_extensions.dart';

// class LoanListCard extends StatelessWidget {
//   final String loanId;

//   const LoanListCard({super.key, required this.loanId});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   LoanPage(loanId: loanId),
//             ));
//       },
//       child: Container(
//         margin: const EdgeInsets.all(10),
//         padding: const EdgeInsets.all(10),
//         // height: 50,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: const Color(0xFFF8F8F8),
//           border: Border(
//             bottom: BorderSide(
//               color: Colors.grey[300]!,
//             ),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             MyAvatarComponent(name: client.name, avatarImagePath: client.avatarImagePath),
//             const SizedBox(width: 15),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     DotPaymentStatus(paymentStatus: loan.paymentStatus),
//                     const SizedBox(width: 5),
//                     ParagraphOneText(
//                         text: client.name, fontWeight: FontWeight.bold),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const ParagraphTwoText(
//                         text: "Interest: ", fillColor: Color(0xFF9EA6A7)),
//                     ParagraphTwoText(
//                         text: "${loan.initialInterestRate}% ",
//                         fillColor: const Color(0xFF1C2829)),
//                     const ParagraphTwoText(
//                         text: "| ", fillColor: Color(0xFF9EA6A7)),
//                     const ParagraphTwoText(
//                         text: "Monthly", fillColor: Color(0xFF1C2829)),
//                   ],
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const ParagraphTwoText(text: "Remaining"),
//                       BigAmountText(
//                           text: loan.remainingPrincipalAmount.toFormattedCurrency())
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
