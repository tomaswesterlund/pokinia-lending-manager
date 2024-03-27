import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/loan_types.dart';
import 'package:pokinia_lending_manager/presentation/pages/loans/open_ended/open_ended_loan_page.dart';
import 'package:pokinia_lending_manager/presentation/pages/loans/zero_interest/zero_interest_loan_page.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/loan_page_view_model.dart';
import 'package:provider/provider.dart';

class LoanPage extends StatelessWidget {
  final String loanId;
  const LoanPage({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanPageViewModel>(
      builder: (context, vm, _) {
        var loanType = vm.getLoanType(loanId);

        if (loanType == LoanTypes.zeroInterestLoan) {
          return ZeroInterestLoanPage(loanId: loanId);
        } else if (loanType == LoanTypes.openEndedLoan) {
          return OpenEndedLoanPage(loanId: loanId);
        } else {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Under construction ..."),
              ),
              body: const Text("Loan page not implemented!"));
        }
      },
    );
  }
}
