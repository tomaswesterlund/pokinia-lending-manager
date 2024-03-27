import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_entity.dart';
import 'package:pokinia_lending_manager/domain/entities/payment_entity.dart';
import 'package:pokinia_lending_manager/domain/entities/zero_interest_loan_entity.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/zero_interest_loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/payment_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class ZeroInterestLoanPageViewModel extends BaseViewModel {
  final ClientService _clientService;
  final LoanService _loanService;
  final PaymentService _paymentService;
  final ZeroInterestLoanService _zeroInterestLoanService;

  ZeroInterestLoanPageViewModel(this._clientService, this._loanService,
      this._paymentService, this._zeroInterestLoanService) {
    _clientService.addListener(notifyListeners);
    _loanService.addListener(notifyListeners);
    _paymentService.addListener(notifyListeners);
    _zeroInterestLoanService.addListener(notifyListeners);
  }

  Either<CustomError, ZeroInterestLoanPageViewModelEntities> getEntities(
      String loanId) {
    try {
      state = States.loading;

      var loan = _loanService.getLoanById(loanId);
      var zeroInterestLoan =
          _zeroInterestLoanService.getZeroInterestLoanByLoanId(loanId);
      var payments = _paymentService.getByLoanId(loanId);
      var client = _clientService.getClientById(loan.clientId);

      state = States.ready;
      return Right(ZeroInterestLoanPageViewModelEntities(
          client, loan, zeroInterestLoan, payments));
    } catch (e) {
      state = States.error;
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}

class ZeroInterestLoanPageViewModelEntities {
  final ClientEntity client;
  final LoanEntity loan;
  final ZeroInterestLoanEntity zeroInterestLoan;
  final List<PaymentEntity> payments;

  ZeroInterestLoanPageViewModelEntities(
      this.client, this.loan, this.zeroInterestLoan, this.payments);
}
