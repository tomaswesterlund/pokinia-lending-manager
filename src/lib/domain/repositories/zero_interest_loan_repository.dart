import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/data/models/loans/zero_interest_loan_data_model.dart';

mixin ZeroInterestLoanRepository {
  addListener(Function() onChangesNotifyListeners);

  List<ZeroInterestLoanDataModel> getAllZeroInterestLoans();

  ZeroInterestLoanDataModel getZeroInterestLoanById(String id);
  
  ZeroInterestLoanDataModel getZeroInterestLoanByLoanId(String loanId);

  Future<Either<CustomError, Success>> createZeroInterestLoan(
      {required String clientId,
      required double principalAmount,
      required DateTime? expectedPayDate});
}
