import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/loan.dart';
import 'package:pokinia_lending_manager/models/loans/zero_interest_loan.dart';
import 'package:pokinia_lending_manager/models/repsonse.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoanService extends ChangeNotifier {
  final _logger = getLogger('LoanService');
  final supabase = Supabase.instance.client;

  final List<Loan> _loans = [];
  List<Loan> get loans => _loans;

  final List<ZeroInterestLoan> _zeroInterestLoans = [];
  List<ZeroInterestLoan> get zeroInterestLoans => _zeroInterestLoans;

  LoanService() {
    listenToLoans();
  }

  void listenToLoans() {
    supabase.from('loans').stream(primaryKey: ['id']).listen((data) {
      var loans = data.map((map) => Loan.fromMap(map)).toList();
      _loans
        ..clear()
        ..addAll(loans);
      notifyListeners();
    });

    supabase
        .from('zero_interest_loans')
        .stream(primaryKey: ['id']).listen((data) {
      var zeroInterestLoans = data.map((map) => ZeroInterestLoan.fromMap(map)).toList();
      _zeroInterestLoans
        ..clear()
        ..addAll(zeroInterestLoans);
      notifyListeners();
    });
  }

  Loan getLoanById(String id) {
    return loans.firstWhere((loan) => loan.id == id);
  }

  ZeroInterestLoan getZeroInterestLoanByLoanId(String loanId) {
    return zeroInterestLoans.firstWhere((loan) => loan.loanId == loanId);
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

  Future<Response> createZeroInterestLoan(
      {required String clientId,
      required double principalAmount,
      required DateTime? expectedPayDate}) async {
    try {
      await supabase.rpc('create_zero_interest_loan', params: {
        'v_client_id': clientId,
        'v_principal_amount': principalAmount.toString(),
        'v_expected_pay_date': expectedPayDate?.toIso8601String(),
      });

      return Response.success();
    } catch (e) {
      _logger.e(e.toString());
      return Response.error(e.toString());
    }
  }

  Future<Response> calculateLoanValues(String id) async {
    try {
      await supabase.rpc('calculate_loan_values', params: {'v_loan_id': id});

      notifyListeners();

      return Response.success();
    } catch (e) {
      _logger.e(e.toString());
      return Response.error(e.toString());
    }
  }
}
