import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/widgets/settings/show_deleted_loans.dart';

class LoanSettings extends StatelessWidget {
  const LoanSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan settings'),
      ),
      body: Column(
        children: [
          ShowDeletedLoans(),
        ],
      ),
    );
  }
}
