import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';

class PaymentModel {
  final String id;
  final String loanId;
  final String clientId;

  // Expected
  final DateTime expectedPayDate;
  final double expectedInterestAmount;
  final double expectedPrincipalAmount;

  // Actual
  final DateTime? actualPayDate;
  final double interestAmountPaid;
  final double principalAmountPaid;
  final double interestRate;

  // Deleted
  final DateTime? deleteDate;
  final String? deleteReason;

  // Calculated
  final PaymentStatus paymentStatus;

  double get totalRemainingAmountToBePaid =>
      (expectedInterestAmount + expectedPrincipalAmount) -
      (interestAmountPaid + principalAmountPaid);

  PaymentModel({
    required this.id,
    required this.loanId,
    required this.clientId,
    required this.expectedInterestAmount,
    required this.expectedPrincipalAmount,
    required this.interestAmountPaid,
    required this.principalAmountPaid,
    required this.interestRate,
    required this.expectedPayDate,
    required this.actualPayDate,
    required this.deleteDate,
    required this.deleteReason,
    required this.paymentStatus,
  });

  bool get deleted => deleteDate != null;

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      loanId: json['loanId'],
      clientId: json['clientId'],
      expectedInterestAmount: json['expectedInterestAmount'],
      expectedPrincipalAmount: json['expectedPrincipalAmount'],
      interestAmountPaid: json['interestAmountPaid'],
      principalAmountPaid: json['principalAmountPaid'],
      interestRate: json['interestRate'],
      expectedPayDate: json['expectedPayDate'],
      actualPayDate: json['actualPayDate'],
      deleteDate: json['deleteDate'],
      deleteReason: json['deleteReason'],
      paymentStatus: PaymentStatus.fromName(json['paymentStatus']),
    );
  }

  factory PaymentModel.fromFirestore(DocumentSnapshot doc) {
    try {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return PaymentModel(
        id: doc.id,
        loanId: json['loanId'],
        clientId: json['clientId'],
        expectedInterestAmount:
            (json['expectedInterestAmount'] as num).toDouble(),
        expectedPrincipalAmount:
            (json['expectedPrincipalAmount'] as num).toDouble(),
        interestAmountPaid: json['interestAmountPaid'] == null
            ? 0
            : (json['interestAmountPaid'] as num).toDouble(),
        principalAmountPaid: json['principalAmountPaid'] == null
            ? 0
            : (json['principalAmountPaid'] as num).toDouble(),
        interestRate: (json['interestRate'] as num).toDouble(),
        expectedPayDate: json['expectedPayDate'].toDate(),
        actualPayDate: json['actualPayDate'],
        deleteDate: json['deleteDate'],
        deleteReason: json['deleteReason'],
        paymentStatus: PaymentStatus.fromName(json['paymentStatus']),
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
