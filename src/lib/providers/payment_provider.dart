import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/models/data/payment.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentProvider extends ChangeNotifier {
  final Logger _logger = getLogger('PaymentService');
  final supabase = Supabase.instance.client;
  bool loaded = false;

  final List<Payment> _payments = [];

  startListener(Function(String source) onLoaded) {
    supabase.from('payments').stream(primaryKey: ['id']).listen((data) {
      var loans = data.map((map) => Payment.fromMap(map)).toList();
      _payments
        ..clear()
        ..addAll(loans);

      if (!loaded) {
        loaded = true;
        onLoaded('paymentService');
      }

      notifyListeners();
    });
  }

  Payment getById(String id) {
    return _payments.firstWhere((payment) => payment.id == id);
  }

  List<Payment> getByLoanId(String loanId) {
    return _payments.where((payment) => payment.loanId == loanId).toList();
  }

  List<Payment> getByLoanStatementId(String loanStatementId, bool showDeleted) {
    if(showDeleted) {
      return _payments.where((payment) => payment.loanStatementId == loanStatementId).toList();
    } else {
      return _payments.where((payment) => payment.loanStatementId == loanStatementId && !payment.deleted).toList();
    }
  }

  List<Payment> getRecentlyPaidPayments({int days = 14}) {
    var pastDate = DateTime.now().add(Duration(days: (days * -1)));
    return _payments
        .where((payment) => payment.payDate.isAfter(pastDate))
        .toList();
  }

  Future<Response> createPaymentWithoutLoanStatement(
      {required String clientId,
      required String loanId,
      required double interestAmountPaid,
      required double principalAmountPaid,
      required DateTime date,
      required String receiptImageUrl}) async {
    try {
      _logger.i(
          'Adding payment with clientId: $clientId, loanId: $loanId, interestAmountPaid: $interestAmountPaid, principalAmountPaid: $principalAmountPaid, date: $date, receiptImageUrl: $receiptImageUrl');

      var values = {
        'client_id': clientId,
        'loan_id': loanId,
        'interest_amount_paid': interestAmountPaid.toString(),
        'principal_amount_paid': principalAmountPaid.toString(),
        'pay_date': date.toIso8601String(),
        'receipt_image_url': receiptImageUrl,
      };

      await supabase.from('payments').insert(values);

      return Response.success();
    } catch (e) {
      _logger.e('Error adding payment: $e');
      return Response.error(e.toString());
    }
  }

  Future<Response> createPaymentWithLoanStatement(
      {required String clientId,
      required String loanId,
      required String loanStatementId,
      required double interestAmountPaid,
      required double principalAmountPaid,
      required DateTime date,
      required String receiptImageUrl}) async {
    try {
      _logger.i(
          'Adding payment with clientId: $clientId, loanId: $loanId, loanStatementId: $loanStatementId, interestAmountPaid: $interestAmountPaid, principalAmountPaid: $principalAmountPaid, date: $date, receiptImageUrl: $receiptImageUrl');

      var values = {
        'client_id': clientId,
        'loan_id': loanId,
        'loan_statement_id': loanStatementId,
        'interest_amount_paid': interestAmountPaid.toString(),
        'principal_amount_paid': principalAmountPaid.toString(),
        'pay_date': date.toIso8601String(),
        'receipt_image_url': receiptImageUrl,
      };

      await supabase.from('payments').insert(values);

      return Response.success();
    } catch (e) {
      _logger.e('Error adding payment: $e');
      return Response.error(e.toString());
    }
  }

  Future<Response> createPaymentForOpenEndedLoan(
      {required String clientId,
      required String loanId,
      required String loanStatementId,
      required double interestAmountPaid,
      required double principalAmountPaid,
      required DateTime date,
      required String receiptImageUrl}) async {
    try {
      _logger.i(
          'createPaymentForOpenEndedLoan: Adding payment with clientId: $clientId, loanId: $loanId, principalAmountPaid: $principalAmountPaid, date: $date, receiptImageUrl: $receiptImageUrl');

      var values = {
        'v_client_id': clientId,
        'v_loan_id': loanId,
        'v_loan_statement_id': loanStatementId,
        'v_interest_amount_paid': interestAmountPaid.toString(),
        'v_principal_amount_paid': principalAmountPaid.toString(),
        'v_pay_date': date.toIso8601String(),
        'v_receipt_image_url': receiptImageUrl,
      };

      await supabase.rpc('create_payment_for_open_ended_loan', params: values);

      return Response.success();
    } catch (e) {
      _logger.e('Error adding payment: $e');
      return Response.error(e.toString());
    }
  }

  Future<Response> createPaymentForZeroInterestLoan(
      {required String clientId,
      required String loanId,
      required double principalAmountPaid,
      required DateTime date,
      required String receiptImageUrl}) async {
    try {
      _logger.i(
          'createPaymentForZeroInterestLoan: Adding payment with clientId: $clientId, loanId: $loanId, principalAmountPaid: $principalAmountPaid, date: $date, receiptImageUrl: $receiptImageUrl');

      var values = {
        'v_client_id': clientId,
        'v_loan_id': loanId,
        'v_principal_amount_paid': principalAmountPaid.toString(),
        'v_pay_date': date.toIso8601String(),
        'v_receipt_image_url': receiptImageUrl,
      };

      await supabase.rpc('create_payment_for_zero_interest_loan',
          params: values);

      return Response.success();
    } catch (e) {
      _logger.e('Error adding payment: $e');
      return Response.error(e.toString());
    }
  }

  Future<Response> createPayment(
      {required String clientId,
      required String loanId,
      required String loanStatementId,
      required double interestAmountPaid,
      required double principalAmountPaid,
      required DateTime date,
      required String receiptImageUrl}) async {
    try {
      _logger.i(
          'Adding payment with clientId: $clientId, loanId: $loanId, loanStatementId: $loanStatementId, interestAmountPaid: $interestAmountPaid, principalAmountPaid: $principalAmountPaid, date: $date, receiptImageUrl: $receiptImageUrl');

      var values = {
        'client_id': clientId,
        'loan_id': loanId,
        'loan_statement_id': loanStatementId,
        'interest_amount_paid': interestAmountPaid.toString(),
        'principal_amount_paid': principalAmountPaid.toString(),
        'pay_date': date.toIso8601String(),
        'receipt_image_url': receiptImageUrl,
      };

      await supabase.from('payments').insert(values);

      return Response.success();
    } catch (e) {
      _logger.e('Error adding payment: $e');
      return Response.error(e.toString());
    }
  }

  Future<Response> deletePayment(String id, String deleteReason) async {
    try {
      var params = {
        'v_payment_id': id,
        'v_delete_date': DateTime.now().toIso8601String(),
        'v_delete_reason': deleteReason
      };

      await supabase.rpc('delete_payment', params: params);

      return Response.success();
    } catch (e) {
      _logger.e('Error deleting payment: $e');
      return Response.error(e.toString());
    }
  }

  Future<Response> undeletePayment(String id) async {
    try {
      var params = {'v_payment_id': id};

      await supabase.rpc('undelete_payment', params: params);

      return Response.success();
    } catch (e) {
      _logger.e('Error deleting payment: $e');
      return Response.error(e.toString());
    }
  }

  Future<Response> updateReceiptImageUrl(String id, String receiptImageUrl) async {
    try {
      var response = await supabase.from('payments').update({
        'receipt_image_url': receiptImageUrl,
      }).eq('id', id);

      return Response.success();
    } catch (e) {
      _logger.e('Error uploading receipt: $e');
      return Response.error(e.toString());
    }
  }
}
