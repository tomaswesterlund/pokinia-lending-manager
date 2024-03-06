import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/models/data/loans/new_open_ended_loan_parameters.dart';
import 'package:pokinia_lending_manager/models/data/loans/open_ended_loan.dart';
import 'package:pokinia_lending_manager/models/data/loans/zero_interest_loan.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoanService extends ChangeNotifier {
  final _logger = getLogger('LoanService');
  final supabase = Supabase.instance.client;

  final List<Loan> _loans = [];
  List<Loan> get loans => _loans;

  final List<OpenEndedLoan> _openEndedLoans = [];
  List<OpenEndedLoan> get openEndedLoans => _openEndedLoans;

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

    supabase.from('open_ended_loans').stream(primaryKey: ['id']).listen((data) {
      var openEndedLoans =
          data.map((map) => OpenEndedLoan.fromMap(map)).toList();
      _openEndedLoans
        ..clear()
        ..addAll(openEndedLoans);
      notifyListeners();
    });

    supabase
        .from('zero_interest_loans')
        .stream(primaryKey: ['id']).listen((data) {
      var zeroInterestLoans =
          data.map((map) => ZeroInterestLoan.fromMap(map)).toList();
      _zeroInterestLoans
        ..clear()
        ..addAll(zeroInterestLoans);
      notifyListeners();
    });
  }

  Loan getLoanById(String id) {
    return loans.firstWhere((loan) => loan.id == id);
  }

  OpenEndedLoan getOpenEndedLoanByLoanId(String loanId) {
    return openEndedLoans.firstWhere((loan) => loan.loanId == loanId);
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

  Future<Response> createOpenEndedLoan(
      NewOpenEndedLoanParameters params) async {
    try {
      var values = {
        'v_client_id': params.client!.id,
        'v_start_date': params.startDate?.toIso8601String(),
        'v_payment_period': params.paymentPeriod,
        'v_initial_principal_amount': params.principalAmount.toString(),
        'v_interest_rate': params.interestRate.toString()
      };

      await supabase.rpc('create_open_ended_loan', params: values);

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
      _logger.i('calculateLoanValues - id: $id');

      await supabase.rpc('calculate_loan_values', params: {'v_loan_id': id});

      return Response.success();
    } catch (e) {
      _logger.e(e.toString());
      return Response.error(e.toString());
    }
  }

  Future<Response> editOpenEndedLoan(String id, double interestRate, List<String> paymentStatuses) async {
    try {
      _logger.i('editLoan - id: $id');

      var params = {
        'v_loan_id': id,
        'v_interest_rate': interestRate.toString(),
        'v_payment_statuses': paymentStatuses,
      };

      await supabase.rpc('edit_open_ended_loan', params: params);

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
