import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_entity.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/deleted_alert_box.dart';

class DeletedLoan extends StatelessWidget {
  final LoanEntity loan;
  const DeletedLoan({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    if (loan.paymentStatus == PaymentStatus.deleted) {
      return DeletedAlertBox(
          title: 'Loan has been deleted!',
          deleteDate: loan.deleteDate,
          deleteReason: loan.deleteReason);
    } else {
      return const SizedBox.shrink();
    }
  }
}
