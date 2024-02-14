import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pokinia_lending_manager/models/payment_model.dart';
import 'package:pokinia_lending_manager/models/repsonse_model.dart';
import 'package:http/http.dart' as http;

class PaymentService extends ChangeNotifier {
  final String baseApiUrl;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<PaymentModel> payments = [];

  PaymentService({required this.baseApiUrl});

  listenToPayments() {
    _db.collection('payments').snapshots().listen((snapshot) {
      var payments =
          snapshot.docs.map((doc) => PaymentModel.fromFirestore(doc)).toList();

      this.payments = payments;
      notifyListeners();
    });
  }

  PaymentModel getPaymentById(String id) {
    return payments.firstWhere((payment) => payment.id == id);
  }

  List<PaymentModel> getPaymentsByLoanStatementId(String loanStatementId) {
    return payments.where((payment) => payment.loanStatementId == loanStatementId).toList();
  }

  List<PaymentModel> getRecentlyPaidPayments({int days = 14}) {
    var pastDate = DateTime.now().add(Duration(days: (days * -1)));
    return payments.where((payment) => payment.date.isAfter(pastDate)).toList();
  }

  Future<ResponseModel> deletePayment(String paymentId) async {
    final url = Uri.parse('$baseApiUrl/payments/$paymentId');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      // Successful response, handle the result
      print('Function executed successfully. Response: ${response.body}');
    } else {
      // Handle the error
      print(
          'Error calling Firebase function. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return ResponseModel(statusCode: response.statusCode, body: response.body);
  }

  Future<ResponseModel> createPayment(
      {required String clientId,
      required String loanId,
      required String loanStatementId,
      required double interestAmountPaid,
      required double principalAmountPaid,
      required DateTime date,
      required String receiptImagePath
      }) async {
    final url = Uri.parse('$baseApiUrl/payments');

    var body = {
      'clientId': clientId,
      'loanId': loanId,
      'loanStatementId': loanStatementId,
      'interestAmountPaid': interestAmountPaid.toString(),
      'principalAmountPaid': principalAmountPaid.toString(),
      'date': date.toIso8601String(),
      'receiptImagePath': receiptImagePath,
    };

    final response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      // Successful response, handle the result
      print('Function executed successfully. Response: ${response.body}');
    } else {
      // Handle the error
      print(
          'Error calling Firebase function. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    return ResponseModel(statusCode: response.statusCode, body: response.body);
  }
}
