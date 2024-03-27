import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_entity.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class ClientLoanListViewModel extends BaseViewModel {
  final LoanService _loanService;

  ClientLoanListViewModel(this._loanService);

  Either<CustomError, List<LoanEntity>> getLoansForClient(String clientId) {
    try {
      var loans = _loanService.getLoanByClientId(clientId);
      return Right(loans);
    }
    on Exception catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}