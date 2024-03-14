import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/enums/loan_types.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/pages/loans/open_ended/open_ended_loan_page.dart';
import 'package:pokinia_lending_manager/pages/loans/zero_interest_loans/zero_interest_loan_page.dart';
import 'package:provider/provider.dart';

class LoanPage extends StatelessWidget {
  final String loanId;
  const LoanPage({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    var loanService = Provider.of<LoanProvider>(context, listen: false);
    var loan = loanService.getById(loanId);
    
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
  }
}
