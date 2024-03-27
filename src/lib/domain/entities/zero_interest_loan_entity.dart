import 'package:pokinia_lending_manager/data/models/loans/zero_interest_loan_data_model.dart';

class ZeroInterestLoanEntity {
  String id;
  DateTime createdAt;
  String loanId;
  DateTime? expectedPayDate;
  double initialPrincipalAmount;
  double principalAmountPaid;
  
  double get remainingPrincipalAmount => initialPrincipalAmount - principalAmountPaid;
  

  ZeroInterestLoanEntity({
    required this.id,
    required this.createdAt,
    required this.loanId,
    required this.initialPrincipalAmount,
    required this.principalAmountPaid,
    required this.expectedPayDate,
  });

  ZeroInterestLoanEntity.fromDataModel(ZeroInterestLoanDataModel dataModel)
      : id = dataModel.id,
        createdAt = dataModel.createdAt,
        loanId = dataModel.loanId,
        initialPrincipalAmount = dataModel.initialPrincipalAmount,
        principalAmountPaid = dataModel.principalAmountPaid,
        expectedPayDate = dataModel.expectedPayDate;

}