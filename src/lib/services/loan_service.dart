import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/loan.dart';
import 'package:pokinia_lending_manager/models/repsonse.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoanService extends ChangeNotifier {
  final _logger = getLogger('LoanService');
  final supabase = Supabase.instance.client;

  final List<LoanModel> _loans = [];
  List<LoanModel> get loans => _loans;

  LoanService() {
    listenToLoans();
  }

  void listenToLoans() {
    supabase.from('loans').stream(primaryKey: ['id']).listen((data) {
      var loans = data.map((map) => LoanModel.fromMap(map)).toList();
      _loans
        ..clear()
        ..addAll(loans);
      notifyListeners();
    });
  }

  LoanModel getLoanById(String id) {
    return loans.firstWhere((loan) => loan.id == id);
  }

  List<LoanModel> getLoansByClientId(String clientId) {
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
}
