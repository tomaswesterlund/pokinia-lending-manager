import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String id;
  final String clientId;
  final String loanId;
  final String loanStatementId;
  final double interestAmountPaid;
  final double principalAmountPaid;
  final DateTime date;
  final String receiptImagePath;

  // Deleted
  final DateTime? deleteDate;
  final String? deleteReason;

  bool get deleted => deleteDate != null;

  PaymentModel({
    required this.id,
    required this.clientId,
    required this.loanId,
    required this.loanStatementId,
    required this.interestAmountPaid,
    required this.principalAmountPaid,
    required this.date,
    required this.receiptImagePath,
    required this.deleteDate,
    required this.deleteReason,
  });

  factory PaymentModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return PaymentModel(
      id: doc.id,
      clientId: json['clientId'],
      loanId: json['loanId'],
      loanStatementId: json['loanStatementId'],
      interestAmountPaid: (json['interestAmountPaid'] as num).toDouble(),
      principalAmountPaid: (json['principalAmountPaid'] as num).toDouble(),
      date: json['date'].toDate(),
      receiptImagePath: json['receiptImagePath'],
      deleteDate: json['deleteDate']?.toDate(),
      deleteReason: json['deleteReason'],
    );
  }
}