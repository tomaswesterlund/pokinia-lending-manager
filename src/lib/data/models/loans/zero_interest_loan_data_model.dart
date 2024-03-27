import 'package:pokinia_lending_manager/core/util/string_extensions.dart';
import 'package:pokinia_lending_manager/data/models/base_data_model.dart';

class ZeroInterestLoanDataModel extends BaseDataModel {
  final String loanId;
  final DateTime? expectedPayDate;
  final double initialPrincipalAmount;
  final double principalAmountPaid;

  ZeroInterestLoanDataModel({
    required super.id,
    required super.createdAt,
    required this.loanId,
    required this.initialPrincipalAmount,
    required this.principalAmountPaid,
    required this.expectedPayDate,
  });
  
  @override
  factory ZeroInterestLoanDataModel.fromJson(Map<String, dynamic> json) {
    return ZeroInterestLoanDataModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      loanId: json['loan_id'] as String,
      initialPrincipalAmount: json['initial_principal_amount'].toString().toDouble(),
      principalAmountPaid: json['principal_amount_paid'].toString().toDouble(),
      expectedPayDate: json['expected_pay_date'] == null
          ? null
          : DateTime.parse(json['expected_pay_date'] as String),
    );
  }
}
