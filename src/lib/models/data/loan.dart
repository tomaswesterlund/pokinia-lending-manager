import 'package:pokinia_lending_manager/enums/loan_types.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';

class Loan {
  final String id;
  final DateTime createdAt;
  final String clientId;
  final PaymentStatus paymentStatus;
  final LoanTypes type;
  final DateTime? deleteDate;
  final String? deleteReason;


  double get initialPrincipalAmount => -1;
  double get initialInterestRate => -1;
  double get remainingPrincipalAmount => -1;
  double get interestAmountPaid => -1;
  double get principalAmountPaid => -1;
  bool get deleted => paymentStatus == PaymentStatus.deleted;
  
  Loan({
    required this.id,
    required this.createdAt,
    required this.clientId,
    required this.paymentStatus,
    required this.type,
    this.deleteDate,
    this.deleteReason,
  });

  Loan.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        createdAt = data['created_at'].toString().toDate(),
        clientId = data['client_id'],
        // initialPrincipalAmount = data['initial_principal_amount'].toDouble(),
        // initialInterestRate = data['initial_interest_rate'].toDouble(),
        // remainingPrincipalAmount = data['remaining_principal_amount'].toDouble(),
        // interestAmountPaid = data['interest_amount_paid'].toDouble(),
        // principalAmountPaid = data['principal_amount_paid'].toDouble(),
        paymentStatus = PaymentStatus.fromName(data['payment_status']),
        type = LoanTypes.fromName(data['type']),
        deleteDate = data['delete_date']?.toString().toDate(),
        deleteReason = data['delete_reason'];
} 
