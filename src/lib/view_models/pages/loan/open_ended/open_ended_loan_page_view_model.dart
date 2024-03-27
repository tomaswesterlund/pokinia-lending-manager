import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_entity.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_statement_entity.dart';
import 'package:pokinia_lending_manager/domain/entities/open_ended_loan_entity.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/domain/services/open_ended_loan_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class OpenEndedLoanPageViewModel extends BaseViewModel {
  final ClientService _clientService;
  final LoanService _loanService;
  final OpenEndedLoanService _openEndedLoanService;
  final LoanStatementService _loanStatementService;

  OpenEndedLoanPageViewModel({
    required ClientService clientService,
    required LoanService loanService,
    required OpenEndedLoanService openEndedLoanService,
    required LoanStatementService loanStatementService,
  })  : _clientService = clientService,
        _loanService = loanService,
        _openEndedLoanService = openEndedLoanService,
        _loanStatementService = loanStatementService;

  Either<CustomError, OpenEndedLoanPageViewModelEntities> getEntities(
      String loanId) {
    try {
      var openEndedLoan =
          _openEndedLoanService.getOpenEndedLoanByLoanId(loanId);
      var loanStatements =
          _loanStatementService.getLoanStatementsByLoanId(loanId);
      loanStatements
          .sort((b, a) => b.expectedPayDate.compareTo(a.expectedPayDate));

      var loan = _loanService.getLoanById(loanId);
      var client = _clientService.getClientById(loan.clientId);

      return Right(OpenEndedLoanPageViewModelEntities(
        client: client,
        loan: loan,
        openEndedLoan: openEndedLoan,
        loanStatements: loanStatements,
      ));
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}

class OpenEndedLoanPageViewModelEntities {
  ClientEntity client;
  LoanEntity loan;
  OpenEndedLoanEntity openEndedLoan;
  List<LoanStatementEntity> loanStatements;

  OpenEndedLoanPageViewModelEntities({
    required this.client,
    required this.loan,
    required this.openEndedLoan,
    required this.loanStatements,
  });
}
