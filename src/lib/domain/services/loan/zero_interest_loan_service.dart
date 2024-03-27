import 'package:pokinia_lending_manager/domain/entities/zero_interest_loan_entity.dart';
import 'package:pokinia_lending_manager/domain/repositories/zero_interest_loan_repository.dart';

class ZeroInterestLoanService {
  final ZeroInterestLoanRepository _zeroInterestLoanRepository;

  ZeroInterestLoanService(this._zeroInterestLoanRepository);

  void addListener(Function() listener) {
    _zeroInterestLoanRepository.addListener(listener);
  }

  List<ZeroInterestLoanEntity> getAllLoans() {
    var dataModels = _zeroInterestLoanRepository.getAllZeroInterestLoans();
    return dataModels
        .map((dataModel) => ZeroInterestLoanEntity.fromDataModel(dataModel))
        .toList();
  }

  ZeroInterestLoanEntity getZeroInterestLoanByLoanId(String loanId) {
    var data = _zeroInterestLoanRepository.getZeroInterestLoanByLoanId(loanId);
    return ZeroInterestLoanEntity.fromDataModel(data);
  }

  Future createZeroInterestLoan(
      {required String clientId,
      required double principalAmount,
      required DateTime? expectedPayDate}) async {
    await _zeroInterestLoanRepository.createZeroInterestLoan(
        clientId: clientId,
        principalAmount: principalAmount,
        expectedPayDate: expectedPayDate);
  }
}
