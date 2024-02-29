import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/models/payment.dart';
import 'package:pokinia_lending_manager/models/repsonse.dart';
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

  Future<Response> deletePayment(String paymentId) async {
    try {
      _logger.i('Deleting payment with id: $paymentId');

      await supabase.from('payments').delete().match({'id': paymentId});

      return Response.success();
    } catch (e) {
      _logger.e('Error deleting payment: $e');
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
}
