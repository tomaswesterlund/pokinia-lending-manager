import 'package:pokinia_lending_manager/core/models/parameters/new_open_ended_loan_parameters.dart';
import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/domain/entities/open_ended_loan_entity.dart';
import 'package:pokinia_lending_manager/domain/repositories/open_ended_loan_repository.dart';

class OpenEndedLoanService {
  final OpenEndedLoanRepository _openEndedLoanRepository;

  OpenEndedLoanService(this._openEndedLoanRepository);

  OpenEndedLoanEntity getOpenEndedLoanByLoanId(String loanId) {
    var data = _openEndedLoanRepository.getByLoanId(loanId);
    return OpenEndedLoanEntity.fromDataModel(data);
  }

  Future<Response> createLoan(NewOpenEndedLoanParameters params) async {
    return await _openEndedLoanRepository.createLoan(params);
  }
}
