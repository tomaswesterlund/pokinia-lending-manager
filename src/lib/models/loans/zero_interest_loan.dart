import 'package:pokinia_lending_manager/util/string_extensions.dart';

class ZeroInterestLoan {
  String id;
  DateTime createdAt;
  String loanId;
  double initialPrincipalAmount;
  double remainingPrincipalAmount;
  DateTime? expectedPayDate;

  ZeroInterestLoan({
    required this.id,
    required this.createdAt,
    required this.loanId,
    required this.initialPrincipalAmount,
    required this.remainingPrincipalAmount,
    required this.expectedPayDate,
  });

  ZeroInterestLoan.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        createdAt = map['created_at'].toString().toDate(),
        loanId = map['loan_id'],
        initialPrincipalAmount = map['initial_principal_amount'].toDouble(),
        remainingPrincipalAmount = map['remaining_principal_amount'].toDouble(),
        expectedPayDate = map['expected_pay_date']?.toString().toDate();

}