import 'package:pokinia_lending_manager/util/string_extensions.dart';

class ZeroInterestLoan {
  String id;
  DateTime createdAt;
  String loanId;
  DateTime? expectedPayDate;
  double initialPrincipalAmount;
  double principalAmountPaid;
  
  double get principalAmountRemaining => initialPrincipalAmount - principalAmountPaid;
  

  ZeroInterestLoan({
    required this.id,
    required this.createdAt,
    required this.loanId,
    required this.initialPrincipalAmount,
    required this.principalAmountPaid,
    required this.expectedPayDate,
  });

  ZeroInterestLoan.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        createdAt = map['created_at'].toString().toDate(),
        loanId = map['loan_id'],
        expectedPayDate = map['expected_pay_date']?.toString().toDate(),
        initialPrincipalAmount = map['initial_principal_amount'].toDouble(),
        principalAmountPaid = map['principal_amount_paid'].toDouble();

}