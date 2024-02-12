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

  Stream<List<LoanStatementModel>> getOverdueLoanStatementsStream() {
    var stream = _db
        .collection('loan_statements')
        .where('paymentStatus', isEqualTo: 'overdue')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LoanStatementModel.fromFirestore(doc))
            .toList());
    return stream;
  }

  Stream<List<LoanStatementModel>> getUpcomingLoanStatementsStream({int days = 14}){
    var futureDate = DateTime.now().add(Duration(days: days));
    var futureTimestamp = Timestamp.fromDate(futureDate);

    var stream = _db
        .collection('loan_statements')
        .where('paymentStatus', isEqualTo: 'scheduled')
        .where('expectedPayDate', isLessThanOrEqualTo: futureTimestamp)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LoanStatementModel.fromFirestore(doc))
            .toList());
    return stream;
  }

  Stream<List<LoanStatementModel>> getRecentlyPaidLoanStatementsStream({int days = 14}){
    var pastDate = DateTime.now().add(Duration(days: (days * -1)));
    var pastTimestamp = Timestamp.fromDate(pastDate);

    var stream = _db
        .collection('loan_statements')
        .where('paymentStatus', isEqualTo: 'paid')
        .where('expectedPayDate', isGreaterThan: pastTimestamp)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LoanStatementModel.fromFirestore(doc))
            .toList());
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
