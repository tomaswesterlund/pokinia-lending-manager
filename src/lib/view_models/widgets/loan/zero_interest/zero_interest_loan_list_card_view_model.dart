import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_entity.dart';
import 'package:pokinia_lending_manager/domain/entities/zero_interest_loan_entity.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/zero_interest_loan_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class ZeroInterestLoanListCardViewModel extends BaseViewModel {
  final ClientService _clientService;
  final LoanService _loanService;
  final ZeroInterestLoanService _zeroInterestLoanService;

  States _state = States.ready;
  @override
  States get state => _state;

  ZeroInterestLoanListCardViewModel(
      this._clientService, this._loanService, this._zeroInterestLoanService);

  Either<CustomError, ClientEntity> getClientById(String clientId) {
    try {
      _state = States.loading;

      var client = _clientService.getClientById(clientId);

      _state = States.ready;
      return Right(client);
    } catch (e) {
      _state = States.error;
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  Either<CustomError, LoanEntity> getLoanById(String loanId) {
    try {
      _state = States.loading;

      var loan = _loanService.getLoanById(loanId);

      _state = States.ready;
      return Right(loan);
    } catch (e) {
      _state = States.error;
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  Either<CustomError, ZeroInterestLoanEntity> getZeroInterestLoanByLoanId(
      String loanId) {
    try {
      _state = States.loading;

      var zeroInterestLoan =
          _zeroInterestLoanService.getZeroInterestLoanByLoanId(loanId);

      _state = States.ready;
      return Right(zeroInterestLoan);
    } catch (e) {
      _state = States.error;
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
