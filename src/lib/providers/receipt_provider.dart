import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/receipt_model.dart';

class ReceiptProvider extends ChangeNotifier {
  final List<ReceiptModel> _receipts = [];

  ReceiptProvider() {
    _receipts.add(ReceiptModel(
      id: 'habibi_loan_one_receipt_one',
      loanId: 'habibi_loan_one',
      paymentId: 'habibi_loan_one_payment_one',
      clientId: 'habibi',
      date: DateTime.now(),
      interestPayment: 25000,
      principalPayment: 0,
    ));
  }


ReceiptModel getReceiptById(String id) {
    return _receipts.where((receipt) => receipt.id == id).toList().first;
  }

  void addReceipt(ReceiptModel receipt) {
    _receipts.add(receipt);
    notifyListeners();
  }

  void removeReceipt(ReceiptModel receipt) {
    _receipts.remove(receipt);
    notifyListeners();
  }

  List<ReceiptModel> getReceiptsByLoanId(String loanId) {
    return _receipts.where((receipt) => receipt.loanId == loanId).toList();
  }

  List<ReceiptModel> getReceiptsByPaymentId(String paymentId) {
    return _receipts.where((receipt) => receipt.paymentId == paymentId).toList();
  }

  List<ReceiptModel> get receipts => _receipts;
  bool get hasReceipts => _receipts.isNotEmpty;
}