import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_entity.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class ClientZeroInterestLoanListCardViewModel extends BaseViewModel {
  final LoanService _loanService;

  ClientZeroInterestLoanListCardViewModel(this._loanService);

  Either<CustomError, LoanEntity> getLoanById(String loanId) {
    try {
      var loan = _loanService.getLoanById(loanId);
      return Right(loan);
    } on Exception catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

}