import 'package:pokinia_lending_manager/core/models/parameters/new_open_ended_loan_parameters.dart';
import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/data/models/loans/open_ended_loan.dart';

mixin OpenEndedLoanRepository {
  OpenEndedLoanDataModel getById(String id);

  OpenEndedLoanDataModel getByLoanId(String loanId);

  Future<Response> createLoan(
      NewOpenEndedLoanParameters params);

  Future<Response> editLoan(
      String id, double interestRate, List<String> paymentStatuses);
}
