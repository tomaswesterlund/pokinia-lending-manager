import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/widgets/settings/show_deleted_loan_statements.dart';
import 'package:pokinia_lending_manager/presentation/widgets/settings/update_expected_interest_for_overdue_loan_statements.dart';
import 'package:pokinia_lending_manager/presentation/widgets/settings/update_expected_interest_for_scheduled_loan_statements.dart';

class LoanStatementSettings extends StatelessWidget {
  const LoanStatementSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan settings'),
      ),
      body: Column(
        children: [
          ShowDeletedLoanStatements(),
          const UpdateExpectedInterestForOverdueLoanStatements(),
          const UpdateExpectedInterestForScheduledLoanStatements(),
        ],
      ),
    );
  }
}
