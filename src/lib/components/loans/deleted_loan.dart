import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/boxes/deleted_alert_box.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';

class DeletedLoan extends StatelessWidget {
  final Loan loan;
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
