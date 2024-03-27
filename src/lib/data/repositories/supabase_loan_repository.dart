import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/data/models/loans/loan_data_model.dart';
import 'package:pokinia_lending_manager/data/repositories/base_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/loan_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseLoanRepository extends BaseRepository<LoanDataModel>
    with LoanRepository {
  SupabaseLoanRepository(SupabaseClient supabaseClient)
      : super(supabaseClient, DataRepositories.loanRepository, TableNames.loans,
            (data) => LoanDataModel.fromJson(data));

  @override
  List<LoanDataModel> getAllLoans() {
    return data;
  }

  @override
  List<LoanDataModel> getLoanByClientId(String clientId) {
    return data.where((element) => element.clientId == clientId).toList();
  }

  @override
  LoanDataModel getLoanById(String id) {
    return data.firstWhere((element) => element.id == id);
  }

  @override
  Future<Response> createLoan(
      {required String clientId,
      required double initialPrincipalAmount,
      required double initialInterestRate,
      required startDate,
      required paymentPeriod}) async {
    try {
      var values = {
        'client_id': clientId,
        'initial_principal_amount': initialPrincipalAmount.toString(),
        'initial_interest_rate': initialInterestRate.toString(),
        'start_date': startDate?.toIso8601String(),
      };

      var response = await supabaseClient.from('loans').insert(values);

      return Response.successWithMessage(message: 'Loan created successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> deleteLoan(String id, String deleteReason) async {
    try {
      var params = {
        'v_loan_id': id,
        'v_delete_date': DateTime.now().toIso8601String(),
        'v_delete_reason': deleteReason,
      };

      await supabaseClient.rpc('delete_loan', params: params);

      return Response.successWithMessage(message: 'Loan deleted successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> undeleteLoan(String id) async {
    try {
      var params = {'v_loan_id': id};

      await supabaseClient.rpc('undelete_loan', params: params);

      return Response.successWithMessage(message: 'Loan undeleted successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> calculateLoanValues(String id) async {
    try {
      var response = await supabaseClient
          .rpc('calculate_loan_values', params: {'v_loan_id': id});

      return Response.successWithMessage(message: 'Loan values calculated successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }
}
