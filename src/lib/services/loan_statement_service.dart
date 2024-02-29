import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/loan_statement_model.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoanStatementService extends ChangeNotifier {
  final _logger = getLogger('LoanStatementService');
  final supabase = Supabase.instance.client;

  final List<LoanStatementModel> _loanStatements = [];
  List<LoanStatementModel> get loanStatements => _loanStatements;

  LoanStatementService() {
    listenToLoanStatements();
  }

  void listenToLoanStatements() {
    supabase.from('loan_statements').stream(primaryKey: ['id']).listen((data) {
      var loans = data.map((map) => LoanStatementModel.fromMap(map)).toList();
      _loanStatements
        ..clear()
        ..addAll(loans);
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
