import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/data/models/loans/loan_data_model.dart';

mixin LoanRepository {
  addListener(Function() onChangesNotifyListeners);

  List<LoanDataModel> getAllLoans();

  List<LoanDataModel> getLoanByClientId(String clientId);

  LoanDataModel getLoanById(String id);

  Future<Response> createLoan(
      {required String clientId,
      required double initialPrincipalAmount,
      required double initialInterestRate,
      required startDate,
      required paymentPeriod});

  Future<Response> calculateLoanValues(String id);

  Future<Response> deleteLoan(
      String id, String deleteReason);

  Future<Response> undeleteLoan(String id);
}
