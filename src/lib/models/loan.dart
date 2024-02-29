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

  LoanModel.Loan({
    required this.id,
    required this.clientId,
    required this.initialPrincipalAmount,
    required this.initialInterestRate,
    required this.remainingPrincipalAmount,
    required this.interestAmountPaid,
    required this.principalAmountPaid,
    required this.paymentStatus,
  });

  LoanModel.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        clientId = data['client_id'],
        initialPrincipalAmount = data['initial_principal_amount'].toDouble(),
        initialInterestRate = data['initial_interest_rate'].toDouble(),
        remainingPrincipalAmount = data['remaining_principal_amount'].toDouble(),
        interestAmountPaid = data['interest_amount_paid'].toDouble(),
        principalAmountPaid = data['principal_amount_paid'].toDouble(),
        paymentStatus = PaymentStatus.fromName(data['payment_status']);
} 
