import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokinia_lending_manager/models/loan_model.dart';
import 'package:pokinia_lending_manager/models/repsonse_model.dart';

class LoanService extends ChangeNotifier {
  final String baseApiUrl;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<LoanModel> loans = [];

  LoanService({required this.baseApiUrl}) {
    listenToLoans();
  }

  void listenToLoans() {
    _db.collection('loans').snapshots().listen((snapshot) {
      var loans =
          snapshot.docs.map((doc) => LoanModel.fromFirestore(doc)).toList();

      this.loans = loans;
      notifyListeners();
    });
  }

  LoanModel getLoanById(String id) {
    return loans.firstWhere((loan) => loan.id == id);
  }

  List<LoanModel> getLoansByClientId(String clientId) {
    return loans.where((loan) => loan.clientId == clientId).toList();
  }

  Future<ResponseModel> createLoan(
      {required String clientId,
      required double initialPrincipalAmount,
      required double initialInterestRate,
      required startDate,
      required paymentPeriod}) async {
    final url = Uri.parse('$baseApiUrl/loans');
    var body = {
      'clientId': clientId,
      'initialPrincipalAmount': initialPrincipalAmount.toString(),
      'initialInterestRate': initialInterestRate.toString(),
      'startDate': startDate?.toIso8601String(),
      'paymentPeriod': paymentPeriod
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

  Future<ResponseModel> recalculateLoan(String loanId, double interestRate) async {
    final url = Uri.parse('$baseApiUrl/loans/recalculate');
    var body = {
      'loanId': loanId,
      'interestRate': interestRate.toString(),
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
