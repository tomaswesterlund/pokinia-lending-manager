import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/data/loan_statement.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoanStatementService extends ChangeNotifier {
  final _logger = getLogger('LoanStatementService');
  final supabase = Supabase.instance.client;

  final List<LoanStatement> _loanStatements = [];
  List<LoanStatement> get loanStatements => _loanStatements;

  LoanStatementService() {
    listenToLoanStatements();
  }

  void listenToLoanStatements() {
    supabase.from('loan_statements').stream(primaryKey: ['id']).listen((data) {
      var loans = data.map((map) => LoanStatement.fromMap(map)).toList();
      _loanStatements
        ..clear()
        ..addAll(loans);
      notifyListeners();
    });
  }

  LoanStatement getLoanStatementById(String id) {
    return loanStatements.firstWhere((loanStatement) => loanStatement.id == id);
  }

  List<LoanStatement> getLoanStatementsByLoanId(String loanId) {
    return loanStatements
        .where((loanStatement) => loanStatement.loanId == loanId)
        .sorted(
            (a, b) => a.expectedPayDate.isBefore(b.expectedPayDate) ? -1 : 1)
        .toList();
  }

  List<LoanStatement> getOverdueLoanStatements() {
    return loanStatements
        .where((loanStatement) =>
            loanStatement.paymentStatus == PaymentStatus.overdue)
        .sorted(
            (a, b) => a.expectedPayDate.isBefore(b.expectedPayDate) ? -1 : 1)
        .toList();
  }

  Future<Response> deleteLoanStatement(String id, String deleteReason) async {
    try {
      var values = {
        'delete_date': DateTime.now().toIso8601String(),
        'delete_reason': deleteReason,
        'payment_status': PaymentStatus.deleted.name.toString()
      };

      await supabase.from('loan_statements').update(values).match({'id': id});

      notifyListeners();

      return Response.success();
    } catch (e) {
      _logger.e('Error deleting loan statement: $e');
      return Response.error(e.toString());
    }
  }

  Future<Response> calculateLoanStatementValues(String id) async {
    try {
      await supabase.rpc('calculate_loan_statement_values', params: {'v_loan_statement_id': id});

      notifyListeners();

      return Response.success();
    } catch (e) {
      _logger.e(e.toString());
      return Response.error(e.toString());
    }
  }
}
