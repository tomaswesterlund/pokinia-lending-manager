import 'package:pokinia_lending_manager/enums/loan_types.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';

class Loan {
  final String id;
  final DateTime createdAt;
  final String clientId;
  // final double initialPrincipalAmount;
  // final double initialInterestRate;
  // final double remainingPrincipalAmount;
  // final double interestAmountPaid;
  // final double principalAmountPaid;
  final PaymentStatus paymentStatus;
  final LoanTypes type;


  double get initialPrincipalAmount => -1;
  double get initialInterestRate => -1;
  double get remainingPrincipalAmount => -1;
  double get interestAmountPaid => -1;
  double get principalAmountPaid => -1;
  
  Loan({
    required this.id,
    required this.createdAt,
    required this.clientId,
    // required this.initialPrincipalAmount,
    // required this.initialInterestRate,
    // required this.remainingPrincipalAmount,
    // required this.interestAmountPaid,
    // required this.principalAmountPaid,
    required this.paymentStatus,
    required this.type,
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
        type = LoanTypes.fromName(data['type']);

  // LoanModel.Loan({
  //   required this.id,
  //   required this.clientId,
  //   required this.initialPrincipalAmount,
  //   required this.initialInterestRate,
  //   required this.remainingPrincipalAmount,
  //   required this.interestAmountPaid,
  //   required this.principalAmountPaid,
  //   required this.paymentStatus,
  // });

  // LoanModel.fromMap(Map<String, dynamic> data)
  //     : id = data['id'],
  //       clientId = data['client_id'],
  //       initialPrincipalAmount = data['initial_principal_amount'].toDouble(),
  //       initialInterestRate = data['initial_interest_rate'].toDouble(),
  //       remainingPrincipalAmount = data['remaining_principal_amount'].toDouble(),
  //       interestAmountPaid = data['interest_amount_paid'].toDouble(),
  //       principalAmountPaid = data['principal_amount_paid'].toDouble(),
  //       paymentStatus = PaymentStatus.fromName(data['payment_status']);
} 
