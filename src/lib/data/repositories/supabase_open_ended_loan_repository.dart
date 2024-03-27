
import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/core/models/parameters/new_open_ended_loan_parameters.dart';
import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/data/models/loans/open_ended_loan.dart';
import 'package:pokinia_lending_manager/data/repositories/base_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/open_ended_loan_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseOpenEndedLoanRepository
    extends BaseRepository<OpenEndedLoanDataModel>
    with OpenEndedLoanRepository {
  SupabaseOpenEndedLoanRepository(SupabaseClient supabaseClient)
      : super(
            supabaseClient,
            DataRepositories.openEndedLoanRepository,
            TableNames.openEndedLoans,
            (data) => OpenEndedLoanDataModel.fromJson(data));

  @override
  OpenEndedLoanDataModel getById(String id) {
    var loan = data.where((loan) => loan.id == id).first;
    return loan;
  }

  @override
  OpenEndedLoanDataModel getByLoanId(String loanId) {
    var loan = data.where((loan) => loan.loanId == loanId).first;
    return loan;
  }

  @override
  Future<Response> createLoan(NewOpenEndedLoanParameters params) async {
    try {
      var values = {
        'v_client_id': params.clientId,
        'v_start_date': params.startDate?.toIso8601String(),
        'v_payment_period': params.paymentPeriod,
        'v_initial_principal_amount': params.principalAmount.toString(),
        'v_interest_rate': params.interestRate.toString()
      };

      await supabaseClient.rpc('create_open_ended_loan', params: values);

      return Response.successWithMessage(message: 'Loan created successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> editLoan(
      String id, double interestRate, List<String> paymentStatuses) async {
    try {
      var params = {
        'v_loan_id': id,
        'v_interest_rate': interestRate.toString(),
        'v_payment_statuses': paymentStatuses,
      };

      await supabaseClient.rpc('edit_open_ended_loan', params: params);

      return Response.successWithMessage(message: 'Loan edited successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }
}
