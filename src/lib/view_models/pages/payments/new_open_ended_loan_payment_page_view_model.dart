import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/domain/services/loan_statement_service.dart';
import 'package:pokinia_lending_manager/domain/services/payment_service.dart';
import 'package:pokinia_lending_manager/domain/services/receipt_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class NewOpenEndedLoanPaymentPageViewModel extends BaseViewModel {
  final LoanStatementService _loanStatementService;
  final PaymentService _paymentService;
  final ReceiptService _receiptService;

  NewOpenEndedLoanPaymentPageViewModel(
      this._loanStatementService, this._paymentService, this._receiptService) {
    _paymentService.addListener(notifyListeners);
  }

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController _interestAmountPaidController =
      TextEditingController();
  TextEditingController get interestAmountPaidController =>
      _interestAmountPaidController;

  final TextEditingController _principalAmountPaidController =
      TextEditingController();
  TextEditingController get principalAmountPaidController =>
      _principalAmountPaidController;

  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  File? _selectedReceiptImage;

  void onReceiptImageSelected(File? image) {
    _selectedReceiptImage = image;
  }

  Future<Either<dynamic, Success>> createPayment(String loanStatementId) async {
    if (_formKey.currentState!.validate()) {
      super.state = States.processing;

      var loanStatement =
          _loanStatementService.getLoanStatementsById(loanStatementId);

      var imageReceiptUrl = await _receiptService
          .uploadReceiptAndGetPublicUrlOrNull(_selectedReceiptImage);

      var response = await _paymentService.createPaymentForOpenEndedLoan(
          clientId: loanStatement.clientId,
          loanId: loanStatement.id,
          loanStatementId: loanStatement.id,
          principalAmountPaid:
              double.parse(_principalAmountPaidController.text),
          interestAmountPaid: double.parse(_interestAmountPaidController.text),
          date: DateTime.now(),
          receiptImageUrl: imageReceiptUrl,
          description: _descriptionController.text);

      if (response.succeeded) {
        super.state = States.ready;
        return Right(Success());
      } else {
        super.state = States.error;
        return Left(response.message);
      }
    } else {
      return Right(Success());
    }
  }
}
