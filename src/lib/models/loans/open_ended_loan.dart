import 'package:pokinia_lending_manager/util/string_extensions.dart';

class OpenEndedLoan {
  String id;
  DateTime createdAt;
  String loanId;
  DateTime startDate;
  String paymentPeriod;
  double initialPrincipalAmount;
  double remainingPrincipalAmount;
  double interestRate;
  double interestAmountPaid;

  double get principalAmountPaid =>
      initialPrincipalAmount - remainingPrincipalAmount;

  OpenEndedLoan({
    required this.id,
    required this.createdAt,
    required this.loanId,
    required this.startDate,
    required this.paymentPeriod,
    required this.initialPrincipalAmount,
    required this.remainingPrincipalAmount,
    required this.interestRate,
    required this.interestAmountPaid,
  });

  OpenEndedLoan.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        createdAt = map['created_at'].toString().toDate(),
        loanId = map['loan_id'],
        startDate = map['start_date'].toString().toDate(),
        paymentPeriod = map['payment_period'],
        initialPrincipalAmount = map['initial_principal_amount'].toDouble(),
        remainingPrincipalAmount = map['remaining_principal_amount'].toDouble(),
        interestRate = map['interest_rate'].toDouble(),
        interestAmountPaid = map['interest_amount_paid'].toDouble();
}