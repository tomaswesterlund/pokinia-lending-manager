import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokinia_lending_manager/enums/loan_payment_status.dart';

class LoanModel {
  final String id;
  final String clientId;
  final double initialPrincipalAmount;
  final double initialInterestRate;
  final double remainingPrincipalAmount;
  final double interestAmountPaid;
  final double principalAmountPaid;
  final LoanPaymentStatus loanPaymentStatus;

  LoanModel({
    required this.id,
    required this.clientId,
    required this.initialPrincipalAmount,
    required this.initialInterestRate,
    required this.remainingPrincipalAmount,
    required this.interestAmountPaid,
    required this.principalAmountPaid,
    required this.loanPaymentStatus,
  });

  factory LoanModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    return LoanModel(
      id: doc.id,
      clientId: json['clientId'],
      initialPrincipalAmount: (json['initialPrincipalAmount'] as num).toDouble(),
      initialInterestRate: (json['initialInterestRate'] as num).toDouble(),
      remainingPrincipalAmount:
          (json['remainingPrincipalAmount'] as num).toDouble(),
      interestAmountPaid: (json['interestAmountPaid'] as num).toDouble(),
      principalAmountPaid: (json['principalAmountPaid'] as num).toDouble(),
      loanPaymentStatus: LoanPaymentStatus.fromName(json['loanPaymentStatus']),
    );
  }

  toJson() {
    return {
      'clientId': clientId,
      'initialPrincipalAmount': initialPrincipalAmount,
      'initialInterestRate': initialInterestRate,
      'remainingPrincipalAmount': remainingPrincipalAmount,
      'interestAmountPaid': interestAmountPaid,
      'principalAmountPaid': principalAmountPaid,
      'loanPaymentStatus': loanPaymentStatus.name.toString(),
    };
  }
}
