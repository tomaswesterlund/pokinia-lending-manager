import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/open_ended_loan_entity.dart';
import 'package:pokinia_lending_manager/domain/services/open_ended_loan_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class ClientOpenEndedLoanListCardViewModel extends BaseViewModel {
  final OpenEndedLoanService _openEndedLoanService;

  ClientOpenEndedLoanListCardViewModel(this._openEndedLoanService);

  Either<CustomError, OpenEndedLoanEntity> getOpenEndedLoanByLoanId(String loanId) {
    try {
      var openEndedLoan = _openEndedLoanService.getOpenEndedLoanByLoanId(loanId);
      return Right(openEndedLoan);
    }
    catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
    
  }
}