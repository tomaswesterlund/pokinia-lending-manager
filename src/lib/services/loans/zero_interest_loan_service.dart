import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/loans/zero_interest_loan.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ZeroInterestLoanService extends ChangeNotifier {
  final _logger = getLogger('ZeroInterestLoan');
  final supabase = Supabase.instance.client;
  bool loaded = false;

  final List<ZeroInterestLoan> _zeroInterestLoans = [];
  List<ZeroInterestLoan> get zeroInterestLoans => _zeroInterestLoans;

  ZeroInterestLoanService() {
    listenToLoans();
  }

  void listenToLoans() {
    supabase
        .from('zero_interest_loans')
        .stream(primaryKey: ['id']).listen((data) {
      var zeroInterestLoans =
          data.map((map) => ZeroInterestLoan.fromMap(map)).toList();

      _zeroInterestLoans
        ..clear()
        ..addAll(zeroInterestLoans);

      loaded = true;

      notifyListeners();
    });
  }

  ZeroInterestLoan getLoanById(String id) {
    return _zeroInterestLoans.firstWhere((loan) => loan.id == id);
  }

  ZeroInterestLoan getLoanByLoanId(String loanId) {
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
      _logger.e(e.toString());
      return Response.error(e.toString());
    }
  }


}
