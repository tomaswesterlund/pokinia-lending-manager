import 'package:pokinia_lending_manager/util/string_extensions.dart';

class Payment {
  final String id;
  final String clientId;
  final String loanId;
  final String? loanStatementId;
  final double interestAmountPaid;
  final double principalAmountPaid;
  final DateTime payDate;
  final String receiptImagePath;

  // Deleted
  final DateTime? deleteDate;
  final String? deleteReason;

  bool get deleted => deleteDate != null;

  Payment({
    required this.id,
    required this.clientId,
    required this.loanId,
    required this.loanStatementId,
    required this.interestAmountPaid,
    required this.principalAmountPaid,
    required this.payDate,
    required this.receiptImagePath,
    required this.deleteDate,
    required this.deleteReason,
  });

  Payment.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        clientId = map['client_id'],
        loanId = map['loan_id'],
        loanStatementId = map['loan_statement_id'],
        interestAmountPaid = map['interest_amount_paid'].toDouble(),
        principalAmountPaid = map['principal_amount_paid'].toDouble(),
        payDate = map['pay_date'].toString().toDate(),
        receiptImagePath = map['receipt_image_path'] ?? '',
        deleteDate = map['delete_date']?.toString().toDate(),
        deleteReason = map['delete_reason'];
}