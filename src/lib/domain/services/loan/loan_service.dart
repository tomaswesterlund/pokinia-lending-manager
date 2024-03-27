import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_entity.dart';
import 'package:pokinia_lending_manager/domain/repositories/loan_repository.dart';

class LoanService {
  final LoanRepository _loanRepository;

  LoanService(this._loanRepository);

  List<LoanEntity> getAllLoans() {
    var dataModels = _loanRepository.getAllLoans();
    return dataModels
        .map((dataModel) => LoanEntity.fromDataModel(dataModel))
        .toList();
  }

  List<LoanEntity> getLoanByClientId(String clientId) {
    var data = _loanRepository.getLoanByClientId(clientId);
    return data.map((dataModel) => LoanEntity.fromDataModel(dataModel)).toList();
  }

  LoanEntity getLoanById(String id) {
    var dataModel = _loanRepository.getLoanById(id);
    return LoanEntity.fromDataModel(dataModel);
  }

  Future<Response> calculateLoanValues(String id) async {
    return await _loanRepository.calculateLoanValues(id);
  }

  Future<Response> deleteLoan(
      String id, String deleteReason) async {
    return await _loanRepository.deleteLoan(id, deleteReason);
  }

  Future<Response> undeleteLoan(String id) async {
    return await _loanRepository.undeleteLoan(id);
  }

  void addListener(Function() listener) {
    _loanRepository.addListener(listener);
  }
}
