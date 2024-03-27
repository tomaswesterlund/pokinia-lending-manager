import 'package:pokinia_lending_manager/core/util/string_extensions.dart';
import 'package:pokinia_lending_manager/data/models/base_data_model.dart';

class LoanStatementDataModel extends BaseDataModel {
  final String loanId;
  final String clientId;
  final String paymentStatus;

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

  LoanStatementDataModel({
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

  factory LoanStatementDataModel.fromJson(Map<String, dynamic> json) {
    return LoanStatementDataModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      loanId: json['loan_id'],
      clientId: json['client_id'],
      expectedInterestAmount: json['expected_interest_amount'].toString().toDouble(),
      expectedPrincipalAmount: json['expected_principal_amount'].toString().toDouble(),
      interestAmountPaid: json['interest_amount_paid'].toString().toDouble(),
      principalAmountPaid: json['principal_amount_paid'].toString().toDouble(),
      interestRate: json['interest_rate'].toString().toDouble(),
      expectedPayDate: DateTime.parse(json['expected_pay_date']),
      deleteDate: json['delete_date'] != null
          ? DateTime.parse(json['delete_date'])
          : null,
      deleteReason: json['delete_reason'],
      paymentStatus: json['payment_status'],
    );
  }
}
