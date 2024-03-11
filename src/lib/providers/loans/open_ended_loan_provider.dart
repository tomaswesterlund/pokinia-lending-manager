import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/loans/open_ended_loan.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/models/loans/new_open_ended_loan_parameters.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OpenEndedLoanProvider extends ChangeNotifier {
  final logger = getLogger('OpenEndedLoanService');
  final supabase = Supabase.instance.client;
  bool loaded = false;

  final List<OpenEndedLoan> _openEndedLoans = [];
  List<OpenEndedLoan> get openEndedLoans => _openEndedLoans;

  void startListener(Function(String source) onLoaded) {
    supabase.from('open_ended_loans').stream(primaryKey: ['id']).listen((data) {
      var openEndedLoans =
          data.map((map) => OpenEndedLoan.fromMap(map)).toList();

      _openEndedLoans
        ..clear()
        ..addAll(openEndedLoans);

      if (!loaded) {
        loaded = true;
        onLoaded('openEndedLoanService');
      }

      notifyListeners();
    });
  }

  OpenEndedLoan getById(String id) {
    return _openEndedLoans.firstWhere((loan) => loan.id == id);
  }

  OpenEndedLoan getByLoanId(String loanId) {
    return _openEndedLoans.firstWhere((loan) => loan.loanId == loanId);
  }

  Future<Response> createLoan(NewOpenEndedLoanParameters params) async {
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
      logger.e(e.toString());
      return Response.error(e.toString());
    }
  }

  Future<Response> editLoan(
      String id, double interestRate, List<String> paymentStatuses) async {
    try {
      logger.i('editLoan - id: $id');

      var params = {
        'v_loan_id': id,
        'v_interest_rate': interestRate.toString(),
        'v_payment_statuses': paymentStatuses,
      };

      await supabase.rpc('edit_open_ended_loan', params: params);

      return Response.success();
    } catch (e) {
      logger.e(e.toString());
      return Response.error(e.toString());
    }
  }
}
