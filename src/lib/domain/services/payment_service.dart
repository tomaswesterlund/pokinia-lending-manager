import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/domain/entities/payment_entity.dart';
import 'package:pokinia_lending_manager/domain/repositories/payment_repository.dart';

class PaymentService {
  final PaymentRepository _paymentRepository;

  PaymentService(this._paymentRepository);

  void addListener(Function() listener) {
    _paymentRepository.addListener(listener);
  }

  PaymentEntity getById(String id) {
    var data = _paymentRepository.getById(id);
    return PaymentEntity.fromDataModel(data);
  }

  List<PaymentEntity> getByLoanId(String loanId) {
    var data = _paymentRepository.getByLoanId(loanId);
    return data.map((e) => PaymentEntity.fromDataModel(e)).toList();
  }

  List<PaymentEntity> getByLoanStatementId(String loanStatementId) {
    var data = _paymentRepository.getByLoanStatementId(loanStatementId);
    return data.map((e) => PaymentEntity.fromDataModel(e)).toList();
  }

  Future<Response> createPaymentForOpenEndedLoan(
          {required String clientId,
          required String loanId,
          required String loanStatementId,
          required double interestAmountPaid,
          required double principalAmountPaid,
          required DateTime date,
          required String? receiptImageUrl,
          required String? description}) async =>
      await _paymentRepository.createPaymentForOpenEndedLoan(
          clientId: clientId,
          loanId: loanId,
          loanStatementId: loanStatementId,
          interestAmountPaid: interestAmountPaid,
          principalAmountPaid: principalAmountPaid,
          date: date,
          receiptImageUrl: receiptImageUrl,
          description: description);

  Future<Response> createPaymentForZeroInterestLoan(
      {required String clientId,
      required String loanId,
      required double principalAmountPaid,
      required DateTime date,
      required String? receiptImageUrl,
      required String? description}) async {
    return await _paymentRepository.createPaymentForZeroInterestLoan(
        clientId: clientId,
        loanId: loanId,
        principalAmountPaid: principalAmountPaid,
        date: date,
        receiptImageUrl: receiptImageUrl,
        description: description);
  }

  Future<Response> updateReceiptImageUrl(
      String paymentId, String receiptImageUrl) async {
    return await _paymentRepository.updateReceiptImageUrl(
        paymentId, receiptImageUrl);
  }
}
