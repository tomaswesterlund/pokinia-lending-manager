import 'package:pokinia_lending_manager/domain/entities/loan_statement_entity.dart';
import 'package:pokinia_lending_manager/domain/repositories/loan_statement_repository.dart';

class LoanStatementService{
  final LoanStatementRepository _loanStatementRepository;

  LoanStatementService(this._loanStatementRepository);

  LoanStatementEntity getLoanStatementsById(String id) {
    var data = _loanStatementRepository.getLoanStatementById(id);
    return LoanStatementEntity.fromDataModel(data);
  }

  List<LoanStatementEntity> getLoanStatementsByLoanId(String loanId) {
    var data = _loanStatementRepository.getByLoanId(loanId);
    return data.map((e) => LoanStatementEntity.fromDataModel(e)).toList();
  }
}
