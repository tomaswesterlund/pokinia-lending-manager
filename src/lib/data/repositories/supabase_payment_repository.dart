import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/data/models/payment_data_model.dart';
import 'package:pokinia_lending_manager/data/repositories/base_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/payment_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePaymentRepository extends BaseRepository<PaymentDataModel>
    with PaymentRepository {
  SupabasePaymentRepository(SupabaseClient supabaseClient)
      : super(supabaseClient, DataRepositories.paymentRepository,
            TableNames.payments, (data) => PaymentDataModel.fromJson(data));

  @override
  PaymentDataModel getById(String id) {
    return data.where((payment) => payment.id == id).first;
  }

  @override
  List<PaymentDataModel> getByLoanId(String loanId) {
    return data.where((payment) => payment.loanId == loanId).toList();
  }

  @override
  List<PaymentDataModel> getByLoanStatementId(String loanStatementId) {
    var payments = data
        .where((payment) => payment.loanStatementId == loanStatementId)
        .toList();

    return payments;
  }

  @override
  Future<Response> deletePayment(String id, String deleteReason) async {
    try {
      var params = {
        'v_payment_id': id,
        'v_delete_date': DateTime.now().toIso8601String(),
        'v_delete_reason': deleteReason,
      };

      await supabaseClient.rpc('delete_payment', params: params);

      return Response.successWithMessage(
          message: 'Payment deleted successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> undeletePayment(String id) async {
    try {
      var params = {'v_payment_id': id};

      await supabaseClient.rpc('undelete_payment', params: params);

      return Response.successWithMessage(
          message: 'Payment undeleted successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> createPaymentForOpenEndedLoan(
      {required String clientId,
      required String loanId,
      required String loanStatementId,
      required double interestAmountPaid,
      required double principalAmountPaid,
      required DateTime date,
      required String? receiptImageUrl,
      required String? description}) async {
    try {
      var values = {
        'v_client_id': clientId,
        'v_loan_id': loanId,
        'v_loan_statement_id': loanStatementId,
        'v_interest_amount_paid': interestAmountPaid.toString(),
        'v_principal_amount_paid': principalAmountPaid.toString(),
        'v_pay_date': date.toIso8601String(),
        'v_receipt_image_url': receiptImageUrl,
        'v_description': description,
      };

      var response = await supabaseClient
          .rpc('create_payment_for_open_ended_loan', params: values);

      return Response.success();
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> createPaymentForZeroInterestLoan(
      {required String clientId,
      required String loanId,
      required double principalAmountPaid,
      required DateTime date,
      required String? receiptImageUrl,
      required String? description}) async {
    try {
      var values = {
        'v_client_id': clientId,
        'v_loan_id': loanId,
        'v_principal_amount_paid': principalAmountPaid.toString(),
        'v_pay_date': date.toIso8601String(),
        'v_receipt_image_url': receiptImageUrl,
        'v_description': description,
      };

      var response = await supabaseClient
          .rpc('create_payment_for_zero_interest_loan', params: values);

      return Response.successWithMessage(
          message: 'Payment created successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> updateReceiptImageUrl(
      String paymentId, String receiptImageUrl) async {
    try {
      var response = await supabaseClient.from('payments').update({
        'receipt_image_url': receiptImageUrl,
      }).eq('id', paymentId);

      return Response.successWithMessage(
          message: 'Receipt image uploaded successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }
}
