import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';

class LoanStatementModel {
  final String id;
  final String loanId;
  final String clientId;

  // Expected
  final DateTime expectedPayDate;
  final double expectedInterestAmount;
  final double expectedPrincipalAmount;

  // Actual
  // final DateTime? actualPayDate;
  final double interestAmountPaid;
  final double principalAmountPaid;
  final double remainingAmountToBePaid;
  final double interestRate;


  // Deleted
  final DateTime? deleteDate;
  final String? deleteReason;

  // Calculated
  final PaymentStatus paymentStatus;

  LoanStatementModel({
    required this.id,
    required this.loanId,
    required this.clientId,
    required this.expectedInterestAmount,
    required this.expectedPrincipalAmount,
    required this.interestAmountPaid,
    required this.principalAmountPaid,
    required this.remainingAmountToBePaid,
    required this.interestRate,
    required this.expectedPayDate,
    required this.deleteDate,
    required this.deleteReason,
    required this.paymentStatus,
  });

  bool get deleted => deleteDate != null;

  factory LoanStatementModel.fromJson(Map<String, dynamic> json) {
    return LoanStatementModel(
      id: json['id'],
      loanId: json['loanId'],
      clientId: json['clientId'],
      expectedInterestAmount: json['expectedInterestAmount'],
      expectedPrincipalAmount: json['expectedPrincipalAmount'],
      interestAmountPaid: json['interestAmountPaid'],
      principalAmountPaid: json['principalAmountPaid'],
      remainingAmountToBePaid: json['remainingAmountToBePaid'],
      interestRate: json['interestRate'],
      expectedPayDate: json['expectedPayDate'],
      // actualPayDate: json['actualPayDate'],
      deleteDate: json['deleteDate'],
      deleteReason: json['deleteReason'],
      paymentStatus:
          PaymentStatus.fromName(json['paymentStatus']),
    );
  }

  factory LoanStatementModel.fromFirestore(DocumentSnapshot doc) {
    try {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return LoanStatementModel(
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
        remainingAmountToBePaid: (json['remainingAmountToBePaid'] as num).toDouble(),
        interestRate: (json['interestRate'] as num).toDouble(),
        expectedPayDate: json['expectedPayDate'].toDate(),
        // actualPayDate:
        //    json['actualPayDate'] == null ? null : json['actualPayDate'].toDate(),
        deleteDate: json['deleteDate'],
        deleteReason: json['deleteReason'],
        paymentStatus: json['paymentStatus'] == null
            ? PaymentStatus.unknown
            : PaymentStatus.fromName(json['paymentStatus']),
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
