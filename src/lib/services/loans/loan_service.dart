import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoanService extends ChangeNotifier {
  final _logger = getLogger('LoanService');
  final supabase = Supabase.instance.client;

  bool loaded = false;

  final List<Loan> _loans = [];
  List<Loan> get loans => _loans;

  LoanService() {
    listenToLoans();
  }

  void listenToLoans() {
    supabase.from('loans').stream(primaryKey: ['id']).listen((data) {
      var loans = data.map((map) => Loan.fromMap(map)).toList();
      
      _loans
        ..clear()
        ..addAll(loans);

      loaded = true;
      
      notifyListeners();
    });

  }

  Loan getLoanById(String id) {
    return loans.firstWhere((loan) => loan.id == id);
  }

  List<Loan> getLoansByClientId(String clientId) {
    return loans.where((loan) => loan.clientId == clientId).toList();
  }

  Future<Response> createLoan(
      {required String clientId,
      required double initialPrincipalAmount,
      required double initialInterestRate,
      required startDate,
      required paymentPeriod}) async {
    try {
      var values = {
        'client_id': clientId,
        'initial_principal_amount': initialPrincipalAmount.toString(),
        'initial_interest_rate': initialInterestRate.toString(),
        'start_date': startDate?.toIso8601String(),
      };

      await supabase.from('loans').insert(values);

      return Response.success();
    } catch (e) {
      _logger.e(e.toString());
      return Response.error(e.toString());
    }
  }

  Future<Response> calculateLoanValues(String id) async {
    try {
      _logger.i('calculateLoanValues - id: $id');

      await supabase.rpc('calculate_loan_values', params: {'v_loan_id': id});

      return Response.success();
    } catch (e) {
      _logger.e(e.toString());
      return Response.error(e.toString());
    }
  }

  Future<Response> deleteLoan(String id, String deleteReason) async {
    try {
      _logger.i('deleteLoan - id: $id');

      var params = {
        'v_loan_id': id,
        'v_delete_date': DateTime.now().toIso8601String(),
        'v_delete_reason': deleteReason,
      };

      await supabase.rpc('delete_loan', params: params);

      return Response.success();
    } catch (e) {
      _logger.e(e.toString());
      return Response.error(e.toString());
    }
  }

  Future<Response> undeleteLoan(String id) async {
    try {
      _logger.i('undeleteLoan - id: $id');

      var params = {'v_loan_id': id};

      await supabase.rpc('undelete_loan', params: params);

      return Response.success();
    } catch (e) {
      _logger.e(e.toString());
      return Response.error(e.toString());
    }
  }
}
