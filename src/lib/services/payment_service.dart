import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pokinia_lending_manager/models/payment_model.dart';
import 'package:pokinia_lending_manager/models/repsonse_model.dart';
import 'package:http/http.dart' as http;

class PaymentService extends ChangeNotifier {
  final String baseApiUrl;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  PaymentService({required this.baseApiUrl});

  Future<ResponseModel> createPayment(
      {required String clientId,
      required String loanId,
      required String loanStatementId,
      required double interestAmountPaid,
      required double principalAmountPaid,
      required DateTime date}) async {
    final url = Uri.parse('$baseApiUrl/payments');

    var body = {
      'clientId': clientId,
      'loanId': loanId,
      'loanStatementId': loanStatementId,
      'interestAmountPaid': interestAmountPaid.toString(),
      'principalAmountPaid': principalAmountPaid.toString(),
      'date': date.toIso8601String(),
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

  Stream<List<PaymentModel>> getAllPaymentsStream() {
    var stream = _db.collection('payments').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => PaymentModel.fromFirestore(doc)).toList());
    return stream;
  }

  Stream<PaymentModel> getPaymentByIdStream(String id) {
    var stream = _db
        .collection('payments')
        .doc(id)
        .snapshots()
        .map((doc) => PaymentModel.fromFirestore(doc));
    return stream;
  }

  Stream<List<PaymentModel>> getPaymentsByLoanStatementIdStream(
      String loanStatementId) {
    var stream = _db
        .collection('payments')
        .where('loanStatementId', isEqualTo: loanStatementId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PaymentModel.fromFirestore(doc))
            .toList());
    return stream;
  }

  Stream<List<PaymentModel>> getRecentlyPaidPaymentsStream({int days = 14}) {
    var pastDate = DateTime.now().add(Duration(days: (days * -1)));
    var pastTimestamp = Timestamp.fromDate(pastDate);

    var stream = _db
        .collection('payments')
        .where('date', isGreaterThan: pastTimestamp)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PaymentModel.fromFirestore(doc))
            .toList());
    return stream;
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
}
