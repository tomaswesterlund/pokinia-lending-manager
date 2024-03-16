import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/loans/zero_interest_loan.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/services/log_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ZeroInterestLoanProvider extends ChangeNotifier {
  final LogService _logger = LogService('ZeroInterestLoanProvider');
  final supabase = Supabase.instance.client;
  bool loaded = false;

  final List<ZeroInterestLoan> _zeroInterestLoans = [];
  List<ZeroInterestLoan> get zeroInterestLoans => _zeroInterestLoans;

  void startListener(Function(String source) onLoaded) {
    supabase
        .from('zero_interest_loans')
        .stream(primaryKey: ['id']).listen((data) {
      var zeroInterestLoans =
          data.map((map) => ZeroInterestLoan.fromMap(map)).toList();

      _zeroInterestLoans
        ..clear()
        ..addAll(zeroInterestLoans);

      if (!loaded) {
        loaded = true;
        onLoaded('zeroInterestLoanService');
      }

      notifyListeners();
    });
  }

  ZeroInterestLoan getById(String id) {
    return _zeroInterestLoans.firstWhere((loan) => loan.id == id);
  }

  ZeroInterestLoan getByLoanId(String loanId) {
    return _zeroInterestLoans.firstWhere((loan) => loan.loanId == loanId);
  }

  Future<Response> createLoan(
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
      _logger.e('createLoan', e.toString());
      return Response.error(e.toString());
    }
  }
}
