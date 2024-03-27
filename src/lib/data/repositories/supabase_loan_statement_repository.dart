import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/data/models/loan_statement_data_model.dart';
import 'package:pokinia_lending_manager/data/repositories/base_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/loan_statement_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseLoanStatementRepository
    extends BaseRepository<LoanStatementDataModel>
    with LoanStatementRepository {
  SupabaseLoanStatementRepository(SupabaseClient supabaseClient)
      : super(
            supabaseClient,
            DataRepositories.loanStatementRepository,
            TableNames.loanStatements,
            (data) => LoanStatementDataModel.fromJson(data));

  @override
  Either<CustomError, List<LoanStatementDataModel>> getLoanStatements() {
    try {
      return Right(data);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  @override
  LoanStatementDataModel getLoanStatementById(String id) {
    return data.firstWhere((element) => element.id == id);
  }

  @override
  List<LoanStatementDataModel> getByLoanId(String loanId) {
    var list =
        data.where((loanStatement) => loanStatement.loanId == loanId).toList();
    return list;
  }

  @override
  Either<CustomError, List<LoanStatementDataModel>> getOverdueLoanStatements() {
    try {
      var list = data
          .where((loanStatement) =>
              loanStatement.paymentStatus == PaymentStatus.overdue)
          .toList();

      return Right(list);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  @override
  Future<Either<CustomError, Success>> deleteLoanStatement(
      String id, String deleteReason) async {
    try {
      var values = {
        'v_loan_statement_id': id,
        'v_delete_date': DateTime.now().toIso8601String(),
        'v_delete_reason': deleteReason,
      };

      await supabaseClient.rpc('delete_loan_statement', params: values);

      return Right(Success());
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  @override
  Future<Either<CustomError, Success>> undeleteLoanStatement(String id) async {
    try {
      var values = {'v_loan_statement_id': id};

      await supabaseClient.rpc('undelete_loan_statement', params: values);

      return Right(Success());
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  @override
  Future<Either<CustomError, Success>> calculateLoanStatementValues(
      String id) async {
    try {
      await supabaseClient.rpc('calculate_loan_statement_values',
          params: {'v_loan_statement_id': id});

      notifyListeners();

      return Right(Success());
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
