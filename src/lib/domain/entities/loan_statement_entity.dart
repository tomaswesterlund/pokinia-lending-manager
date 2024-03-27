import 'dart:math';

import 'package:pokinia_lending_manager/core/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/data/models/loan_statement_data_model.dart';
import 'package:pokinia_lending_manager/domain/entities/base_entity.dart';

class LoanStatementEntity extends BaseEntity {
  final String loanId;
  final String clientId;
  final PaymentStatus paymentStatus;

  // Expected
  final DateTime expectedPayDate;
  final double expectedInterestAmount;
  final double expectedPrincipalAmount;

  // Actual
  final double interestAmountPaid;
  final double principalAmountPaid;
  final double interestRate;

  // Deleted
  final DateTime? deleteDate;
  final String? deleteReason;

  double get remainingAmountToBePaid {
    var i = max(0, expectedInterestAmount - interestAmountPaid);
    var p = max(0, expectedPrincipalAmount - principalAmountPaid);

    return (i + p).toDouble();
  }

  bool get deleted => paymentStatus == PaymentStatus.deleted;

  const LoanStatementEntity({
    required super.id,
    required super.createdAt,
    required this.loanId,
    required this.clientId,
    required this.expectedInterestAmount,
    required this.expectedPrincipalAmount,
    required this.interestAmountPaid,
    required this.principalAmountPaid,
    required this.interestRate,
    required this.expectedPayDate,
    required this.deleteDate,
    required this.deleteReason,
    required this.paymentStatus,
  });

  factory LoanStatementEntity.fromDataModel(LoanStatementDataModel dataModel) {
    return LoanStatementEntity(
      id: dataModel.id,
      createdAt: dataModel.createdAt,
      loanId: dataModel.loanId,
      clientId: dataModel.clientId,
      expectedInterestAmount: dataModel.expectedInterestAmount,
      expectedPrincipalAmount: dataModel.expectedPrincipalAmount,
      interestAmountPaid: dataModel.interestAmountPaid,
      principalAmountPaid: dataModel.principalAmountPaid,
      interestRate: dataModel.interestRate,
      expectedPayDate: dataModel.expectedPayDate,
      deleteDate: dataModel.deleteDate,
      deleteReason: dataModel.deleteReason,
      paymentStatus: PaymentStatus.fromName(dataModel.paymentStatus),
    );
  }
}
