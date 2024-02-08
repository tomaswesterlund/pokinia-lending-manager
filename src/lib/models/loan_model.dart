import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';

class LoanModel {
  final String id;
  final String clientId;
  final double initialPrincipalAmount;
  final double initialInterestRate;
  final double remainingPrincipalAmount;
  final double interestAmountPaid;
  final double principalAmountPaid;
  final PaymentStatus paymentStatus;

  LoanModel({
    required this.id,
    required this.clientId,
    required this.initialPrincipalAmount,
    required this.initialInterestRate,
    required this.remainingPrincipalAmount,
    required this.interestAmountPaid,
    required this.principalAmountPaid,
    required this.paymentStatus,
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
      paymentStatus: PaymentStatus.fromName(json['paymentStatus']),
    );
  }

  toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'initialPrincipalAmount': initialPrincipalAmount,
      'initialInterestRate': initialInterestRate,
      'remainingPrincipalAmount': remainingPrincipalAmount,
      'interestAmountPaid': interestAmountPaid,
      'principalAmountPaid': principalAmountPaid,
      'paymentStatus': paymentStatus.name.toString(),
    };
  }
}
