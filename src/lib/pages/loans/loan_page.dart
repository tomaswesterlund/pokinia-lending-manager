import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/enums/loan_types.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/pages/loans/open_ended/open_ended_loan_page.dart';
import 'package:pokinia_lending_manager/pages/loans/zero_interest/zero_interest_loan_page.dart';

class LoanPage extends StatelessWidget {
  final Loan loan;
  const LoanPage({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    if (loan.type == LoanTypes.zeroInterestLoan) {
      return ZeroInterestLoanPage(loanId: loan.id);
    } else if (loan.type == LoanTypes.openEndedLoan) {
      return OpenEndedLoanPage(loanId: loan.id);
    } 
    else {
      return  Scaffold(
        appBar: AppBar(
          title: const Text("Under construction ..."),
        ),
        body: const Text("Loan page not implemented!"));
    }

    // return Consumer2<ClientService, LoanService>(
    //   builder: (context, clientService, loanService, _) {
    //     var client = clientService.getClientById(loan.clientId);
    //     //var loan = loanService.getLoanById(loan.id);

    //     return Scaffold(
    //       appBar: AppBar(
    //         title: const Text("Loan page"),
    //         actions: [
    //           PopupMenuButton<int>(
    //             onSelected: (value) async {
    //               if (value == 0) {
    //                 await loanService.calculateLoanValues(loan.id);
    //               }
    //             },
    //             itemBuilder: (context) => [
    //               const PopupMenuItem<int>(
    //                 value: 0,
    //                 child: Column(
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Icon(Icons.calculate),
    //                         SizedBox(width: 12.0),
    //                         Text(
    //                           "Recalculate loan",
    //                         )
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               const PopupMenuDivider(),
    //               const PopupMenuItem<int>(
    //                 value: 1,
    //                 child: Column(
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Icon(Icons.edit),
    //                         SizedBox(width: 12.0),
    //                         Text(
    //                           "Edit loan",
    //                         )
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               const PopupMenuDivider(),
    //               const PopupMenuItem<int>(
    //                 value: 2,
    //                 child: Column(
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Icon(
    //                           Icons.delete,
    //                           color: Colors.red,
    //                         ),
    //                         SizedBox(width: 12.0),
    //                         Text(
    //                           "Delete loan",
    //                         )
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //       body: Column(
    //         children: [
    //           LoanUserStatus(client: client, loan: loan),
    //           LoanSummary(loan: loan),
    //           LoanStatementTable(loanId: loan.id),
    //           const SizedBox(height: 50)
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
