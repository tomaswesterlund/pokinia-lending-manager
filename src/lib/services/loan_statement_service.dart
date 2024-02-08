import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokinia_lending_manager/models/loan_statement_model.dart';

class LoanStatementService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<LoanStatementModel> getLoanStatementByIdStream(String id) {
    var stream = _db
        .collection('loan_statements')
        .doc(id)
        .snapshots()
        .map((doc) => LoanStatementModel.fromFirestore(doc));
    return stream;
  }

  Stream<List<LoanStatementModel>> getLoanStatementsByLoanIdStream(String loanId) {
    var stream = _db
        .collection('loan_statements')
        .where('loanId', isEqualTo: loanId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LoanStatementModel.fromFirestore(doc))
            .toList());
    return stream;
  }
}
