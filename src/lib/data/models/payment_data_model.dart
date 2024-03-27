import 'package:pokinia_lending_manager/core/util/string_extensions.dart';
import 'package:pokinia_lending_manager/data/models/base_data_model.dart';

class PaymentDataModel extends BaseDataModel {
  final String clientId;
  final String loanId;
  final String? loanStatementId;
  final double interestAmountPaid;
  final double principalAmountPaid;
  final DateTime payDate;
  final String? receiptImageUrl;
  final String? description;

  // Deleted
  final DateTime? deleteDate;
  final String? deleteReason;

  bool get deleted => deleteDate != null;

  PaymentDataModel({
    required super.id,
    required super.createdAt,
    required this.clientId,
    required this.loanId,
    required this.loanStatementId,
    required this.interestAmountPaid,
    required this.principalAmountPaid,
    required this.payDate,
    required this.receiptImageUrl,
    required this.deleteDate,
    required this.deleteReason,
    this.description,
  });

  factory PaymentDataModel.fromJson(Map<String, dynamic> json) {
    return PaymentDataModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      clientId: json['client_id'],
      loanId: json['loan_id'],
      loanStatementId: json['loan_statement_id'],
      interestAmountPaid: json['interest_amount_paid'].toString().toDouble(),
      principalAmountPaid: json['principal_amount_paid'].toString().toDouble(),
      payDate: DateTime.parse(json['pay_date']),
      receiptImageUrl: json['receipt_image_url'],
      deleteDate: json['delete_date'] != null
          ? DateTime.parse(json['delete_date'])
          : null,
      deleteReason: json['delete_reason'],
      description: json['description'],
    );
  }
}
