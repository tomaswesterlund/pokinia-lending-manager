import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/data/models/payment_data_model.dart';

mixin PaymentRepository {
  addListener(Function() onChangesNotifyListeners);

  PaymentDataModel getById(String id);

  List<PaymentDataModel> getByLoanId(String loanId);

  List<PaymentDataModel> getByLoanStatementId(String loanStatementId);

  // Future<Response> createPaymentWithoutLoanStatement(
  //     {required String clientId,
  //     required String loanId,
  //     required double interestAmountPaid,
  //     required double principalAmountPaid,
  //     required DateTime date,
  //     required String receiptImageUrl});

  // Future<Response> createPaymentWithLoanStatement(
  //     {required String clientId,
  //     required String loanId,
  //     required String loanStatementId,
  //     required double interestAmountPaid,
  //     required double principalAmountPaid,
  //     required DateTime date,
  //     required String receiptImageUrl});

  Future<Response> createPaymentForZeroInterestLoan(
      {required String clientId,
      required String loanId,
      required double principalAmountPaid,
      required DateTime date,
      required String? receiptImageUrl,
      required String? description});

  Future<Response> createPaymentForOpenEndedLoan(
      {required String clientId,
      required String loanId,
      required String loanStatementId,
      required double interestAmountPaid,
      required double principalAmountPaid,
      required DateTime date,
      required String? receiptImageUrl,
      required String? description});

  Future<Response> deletePayment(String id, String deleteReason);

  Future<Response> undeletePayment(String id);

  Future<Response> updateReceiptImageUrl(
      String paymentId, String receiptImageUrl);
}
