import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/loan_types.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/zero_interest_loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/open_ended_loan_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class ExpectedPayDateViewModel extends BaseViewModel {
  final LoanService _loanService;
  final OpenEndedLoanService _openEndedLoanService;
  final ZeroInterestLoanService _zeroInterestLoanService;

  ExpectedPayDateViewModel(this._loanService, this._openEndedLoanService,
      this._zeroInterestLoanService);

  Either<CustomError, DateTime?> getExpectedPayDate(String loanId) {
    try {
      var loan = _loanService.getLoanById(loanId);
      if (loan.type == LoanTypes.zeroInterestLoan) {
        var zeroInterestLoan =
            _zeroInterestLoanService.getZeroInterestLoanByLoanId(loanId);
        return Right(zeroInterestLoan.expectedPayDate);
      } else {
        return Left(CustomError.withMessage("Loan type not supported"));
      }
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
