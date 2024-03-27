import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/loan_types.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';

class LoanPageViewModel extends ChangeNotifier {
  final LoanService _loanService;

  final String title = 'Loans';

  LoanPageViewModel(this._loanService);

  LoanTypes getLoanType(String loanId) {
    return _loanService.getLoanById(loanId).type;
  }
}