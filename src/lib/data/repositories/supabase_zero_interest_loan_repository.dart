import 'package:either_dart/src/either.dart';
import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/data/models/loans/zero_interest_loan_data_model.dart';
import 'package:pokinia_lending_manager/data/repositories/base_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/zero_interest_loan_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseZeroInterestLoanRepository
    extends BaseRepository<ZeroInterestLoanDataModel>
    with ZeroInterestLoanRepository {
  SupabaseZeroInterestLoanRepository(SupabaseClient supabaseClient)
      : super(
            supabaseClient,
            DataRepositories.zeroInterestLoansRepository,
            TableNames.zeroInterestLoans,
            (data) => ZeroInterestLoanDataModel.fromJson(data));

  @override
  List<ZeroInterestLoanDataModel> getAllZeroInterestLoans() {
    return data;
  }

  @override
  ZeroInterestLoanDataModel getZeroInterestLoanById(String id) {
    var loans = data;
    var loan = loans.firstWhere((element) => element.id == id);
    return loan;
  }

  @override
  ZeroInterestLoanDataModel getZeroInterestLoanByLoanId(String loanId) {
    var loans = data;
    var loan = loans.firstWhere((element) => element.loanId == loanId);
    return loan;
  }

  @override
  Future<Either<CustomError, Success>> createZeroInterestLoan(
      {required String clientId,
      required double principalAmount,
      required DateTime? expectedPayDate}) async {
    try {
      await supabaseClient.rpc('create_zero_interest_loan', params: {
        'v_client_id': clientId,
        'v_principal_amount': principalAmount.toString(),
        'v_expected_pay_date': expectedPayDate?.toIso8601String(),
      });

      return Right(Success());
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
