import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_entity.dart';
import 'package:pokinia_lending_manager/domain/entities/open_ended_loan_entity.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/open_ended_loan_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class OpenEndedLoanListCardViewModel extends BaseViewModel {
  final ClientService _clientService;
  final LoanService _loanService;
  final OpenEndedLoanService _openEndedLoanService;

  OpenEndedLoanListCardViewModel(
    this._clientService,
    this._loanService,
    this._openEndedLoanService,
  );

  Either<CustomError, OpenEndedLoanListCardViewModelEntities> getEntities(
      String loanId) {
    try {
      var loan = _loanService.getLoanById(loanId);
      var client = _clientService.getClientById(loan.clientId);

      var openEndedLoan =
          _openEndedLoanService.getOpenEndedLoanByLoanId(loanId);
      return Right(OpenEndedLoanListCardViewModelEntities(
        client: client,
        loan: loan,
        openEndedLoan: openEndedLoan,
      ));
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}

class OpenEndedLoanListCardViewModelEntities {
  final ClientEntity client;
  final LoanEntity loan;
  final OpenEndedLoanEntity openEndedLoan;

  OpenEndedLoanListCardViewModelEntities({
    required this.client,
    required this.loan,
    required this.openEndedLoan,
  });
}
