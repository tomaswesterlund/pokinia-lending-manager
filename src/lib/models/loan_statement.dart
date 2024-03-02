import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';

class LoanStatement {
  final Logger _logger = getLogger('LoanStatementModel');
  
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

  LoanStatement({
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

  LoanStatement.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        loanId = map['loan_id'],
        clientId = map['client_id'],
        expectedInterestAmount = map['expected_interest_amount'].toDouble(),
        expectedPrincipalAmount = map['expected_principal_amount'].toDouble(),
        interestAmountPaid = map['interest_amount_paid'].toDouble(),
        principalAmountPaid = map['principal_amount_paid'].toDouble(),
        remainingAmountToBePaid = map['remaining_amount_to_be_paid'].toDouble(),
        interestRate = map['interest_rate'].toDouble(),
        expectedPayDate = map['expected_pay_date'].toString().toDate(),
        deleteDate = map['delete_date']?.toString().toDate(),
        deleteReason = map['delete_reason'],
        paymentStatus = PaymentStatus.fromName(map['payment_status']);
}
