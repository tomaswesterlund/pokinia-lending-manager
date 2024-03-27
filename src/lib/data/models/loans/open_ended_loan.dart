import 'package:pokinia_lending_manager/core/util/string_extensions.dart';
import 'package:pokinia_lending_manager/data/models/base_data_model.dart';

class OpenEndedLoanDataModel extends BaseDataModel {
  String loanId;
  DateTime startDate;
  String paymentPeriod;
  double initialPrincipalAmount;
  double principalAmountPaid;
  double interestRate;
  double interestAmountPaid;

  OpenEndedLoanDataModel({
    required super.id,
    required super.createdAt,
    required this.loanId,
    required this.startDate,
    required this.paymentPeriod,
    required this.initialPrincipalAmount,
    required this.principalAmountPaid,
    required this.interestRate,
    required this.interestAmountPaid,
  });

  OpenEndedLoanDataModel.fromJson(Map<String, dynamic> json)
      : loanId = json['loan_id'],
        startDate = DateTime.parse(json['start_date']),
        paymentPeriod = json['payment_period'],
        initialPrincipalAmount = json['initial_principal_amount'].toString().toDouble(),
        principalAmountPaid = json['principal_amount_paid'].toString().toDouble(),
        interestRate = json['interest_rate'].toString().toDouble(),
        interestAmountPaid = json['interest_amount_paid'].toString().toDouble(),
        super(
          id: json['id'],
          createdAt: DateTime.parse(json['created_at']),
        );
}
