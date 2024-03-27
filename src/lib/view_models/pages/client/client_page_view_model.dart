import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_entity.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';

class ClientPageViewModel extends ChangeNotifier {
  final ClientService _clientService;
  final LoanService _loanService;

  ClientPageViewModel(this._clientService, this._loanService);

  ClientEntity getClientById(String id) {
    return _clientService.getClientById(id);
  }

  List<LoanEntity> getLoansForClient(String clientId) {
    return _loanService.getLoanByClientId(clientId);
  }
}
