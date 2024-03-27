import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/payment_entity.dart';
import 'package:pokinia_lending_manager/domain/services/payment_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class LoanStatementPageViewModel extends BaseViewModel {
  final PaymentService _paymentService;

  LoanStatementPageViewModel(this._paymentService);

  Either<CustomError, List<PaymentEntity>> getPayments(String loanStatementId) {
    try {
      var payments =  _paymentService.getByLoanStatementId(loanStatementId);
      return Right(payments);
    }
    catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  
}