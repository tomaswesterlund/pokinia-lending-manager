import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_entity.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class LoansPageViewModel extends BaseViewModel {
  final LoanService _loanService;

  final String title = 'Loans';

  LoansPageViewModel(this._loanService) {
    _loanService.addListener(notifyListeners);
  }

  Either<CustomError, List<LoanEntity>> getAllLoans() {
    try {
      var loans = _loanService.getAllLoans();
      return Right(loans);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
