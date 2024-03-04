import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/models/data/payment.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentService extends ChangeNotifier {
  final Logger _logger = getLogger('PaymentService');
  final supabase = Supabase.instance.client;

  final List<Payment> _payments = [];
  List<Payment> get payments => _payments;

  PaymentService() {
    listenToPayments();
  }

  listenToPayments() {
    supabase.from('payments').stream(primaryKey: ['id']).listen((data) {
      var loans = data.map((map) => Payment.fromMap(map)).toList();
      _payments
        ..clear()
        ..addAll(loans);

      notifyListeners();
    });
  }

  Payment getPaymentById(String id) {
    return payments.firstWhere((payment) => payment.id == id);
  }

  List<Payment> getPaymentsByLoanId(String loanId) {
    return payments.where((payment) => payment.loanId == loanId).toList();
  }

  List<Payment> getPaymentsByLoanStatementId(String loanStatementId) {
    return payments
        .where((payment) => payment.loanStatementId == loanStatementId)
        .toList();
  }

  List<Payment> getRecentlyPaidPayments({int days = 14}) {
    var pastDate = DateTime.now().add(Duration(days: (days * -1)));
    return payments
        .where((payment) => payment.payDate.isAfter(pastDate))
        .toList();
  }

  Future<Response> createPaymentWithoutLoanStatement(
      {required String clientId,
      required String loanId,
      required double interestAmountPaid,
      required double principalAmountPaid,
      required DateTime date,
      required String receiptImagePath}) async {
    try {
      _logger.i(
          'Adding payment with clientId: $clientId, loanId: $loanId, interestAmountPaid: $interestAmountPaid, principalAmountPaid: $principalAmountPaid, date: $date, receiptImagePath: $receiptImagePath');

      var values = {
        'client_id': clientId,
        'loan_id': loanId,
        'interest_amount_paid': interestAmountPaid.toString(),
        'principal_amount_paid': principalAmountPaid.toString(),
        'pay_date': date.toIso8601String(),
        'receipt_image_path': receiptImagePath,
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
      required String receiptImagePath}) async {
    try {
      _logger.i(
          'Adding payment with clientId: $clientId, loanId: $loanId, loanStatementId: $loanStatementId, interestAmountPaid: $interestAmountPaid, principalAmountPaid: $principalAmountPaid, date: $date, receiptImagePath: $receiptImagePath');

      var values = {
        'client_id': clientId,
        'loan_id': loanId,
        'loan_statement_id': loanStatementId,
        'interest_amount_paid': interestAmountPaid.toString(),
        'principal_amount_paid': principalAmountPaid.toString(),
        'pay_date': date.toIso8601String(),
        'receipt_image_path': receiptImagePath,
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
      required String receiptImagePath}) async {
    try {
      _logger.i(
          'createPaymentForOpenEndedLoan: Adding payment with clientId: $clientId, loanId: $loanId, principalAmountPaid: $principalAmountPaid, date: $date, receiptImagePath: $receiptImagePath');

      var values = {
        'v_client_id': clientId,
        'v_loan_id': loanId,
        'v_loan_statement_id': loanStatementId,
        'v_interest_amount_paid': interestAmountPaid.toString(),
        'v_principal_amount_paid': principalAmountPaid.toString(),
        'v_pay_date': date.toIso8601String(),
        'v_receipt_image_path': receiptImagePath,
      };

      await supabase.rpc('create_payment_for_open_ended_loan', params: values);

      notifyListeners();

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
      required String receiptImagePath}) async {
    try {
      _logger.i(
          'createPaymentForZeroInterestLoan: Adding payment with clientId: $clientId, loanId: $loanId, principalAmountPaid: $principalAmountPaid, date: $date, receiptImagePath: $receiptImagePath');

      var values = {
        'v_client_id': clientId,
        'v_loan_id': loanId,
        'v_principal_amount_paid': principalAmountPaid.toString(),
        'v_pay_date': date.toIso8601String(),
        'v_receipt_image_path': receiptImagePath,
      };

      await supabase.rpc('create_payment_for_zero_interest_loan',
          params: values);

      notifyListeners();

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
      required String receiptImagePath}) async {
    try {
      _logger.i(
          'Adding payment with clientId: $clientId, loanId: $loanId, loanStatementId: $loanStatementId, interestAmountPaid: $interestAmountPaid, principalAmountPaid: $principalAmountPaid, date: $date, receiptImagePath: $receiptImagePath');

      var values = {
        'client_id': clientId,
        'loan_id': loanId,
        'loan_statement_id': loanStatementId,
        'interest_amount_paid': interestAmountPaid.toString(),
        'principal_amount_paid': principalAmountPaid.toString(),
        'pay_date': date.toIso8601String(),
        'receipt_image_path': receiptImagePath,
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
      var values = {
        'delete_date': DateTime.now().toIso8601String(),
        'delete_reason': deleteReason
      };

      await supabase.from('payments').update(values).match({'id': id});

      notifyListeners();

      return Response.success();
    } catch (e) {
      _logger.e('Error deleting payment: $e');
      return Response.error(e.toString());
    }
  }

  Future<Response> undeletePayment(String id) async {
    try {
      var values = {'delete_date': null, 'delete_reason': null};

      await supabase.from('payments').update(values).match({'id': id});

      notifyListeners();

      return Response.success();
    } catch (e) {
      _logger.e('Error deleting payment: $e');
      return Response.error(e.toString());
    }
  }
}
