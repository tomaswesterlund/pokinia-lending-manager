import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/data/models/loan_statement_data_model.dart';

mixin LoanStatementRepository {
  addListener(Function() onChangesNotifyListeners);

  Either<CustomError, List<LoanStatementDataModel>> getLoanStatements();

  LoanStatementDataModel getLoanStatementById(String id);

  List<LoanStatementDataModel> getByLoanId(String loanId);

  Either<CustomError, List<LoanStatementDataModel>> getOverdueLoanStatements();

  Future<Either<CustomError, Success>> deleteLoanStatement(
      String id, String deleteReason);

  Future<Either<CustomError, Success>> undeleteLoanStatement(String id);

  Future<Either<CustomError, Success>> calculateLoanStatementValues(String id);
}
