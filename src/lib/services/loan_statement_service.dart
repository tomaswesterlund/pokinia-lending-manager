import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/loan_statement_model.dart';

class LoanStatementService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<LoanStatementModel> loanStatements = [];

  LoanStatementService() {
    listenToLoanStatements();
  }

  listenToLoanStatements() {
    _db.collection('loan_statements').snapshots().listen((snapshot) {
      var loanStatements = snapshot.docs
          .map((doc) => LoanStatementModel.fromFirestore(doc))
          .toList();

      this.loanStatements = loanStatements;
      notifyListeners();
    });
  }

  LoanStatementModel getLoanStatementById(String id) {
    return loanStatements.firstWhere((loanStatement) => loanStatement.id == id);
  }

  List<LoanStatementModel> getLoanStatementsByLoanId(String loanId) {
    return loanStatements
        .where((loanStatement) => loanStatement.loanId == loanId)
        .sorted(
            (a, b) => a.expectedPayDate.isBefore(b.expectedPayDate) ? -1 : 1)
        .toList();
  }

  List<LoanStatementModel> getOverdueLoanStatements() {
    return loanStatements
        .where((loanStatement) =>
            loanStatement.paymentStatus == PaymentStatus.overdue)
        .sorted(
            (a, b) => a.expectedPayDate.isBefore(b.expectedPayDate) ? -1 : 1)
        .toList();
  }
}
