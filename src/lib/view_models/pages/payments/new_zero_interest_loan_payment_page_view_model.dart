import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/domain/services/loan/loan_service.dart';
import 'package:pokinia_lending_manager/domain/services/payment_service.dart';
import 'package:pokinia_lending_manager/domain/services/receipt_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class NewZeroInterestLoanPaymentPageViewModel extends BaseViewModel {
  final LoanService _loanService;
  final PaymentService _paymentService;
  final ReceiptService _receiptService;

  NewZeroInterestLoanPaymentPageViewModel(
      this._loanService, this._paymentService, this._receiptService);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController _principalAmountPaidController =
      TextEditingController();
  TextEditingController get principalAmountPaidController =>
      _principalAmountPaidController;

  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  File? _selectedImage;
  void onImageSelected(File image) {
    _selectedImage = image;
    notifyListeners();
  }

  Future<Either<CustomError, Success>> createPayment(String loanId) async {
    if (_formKey.currentState!.validate()) {
      var loan = _loanService.getLoanById(loanId);
      var receiptImageUrl = await _receiptService
          .uploadReceiptAndGetPublicUrlOrNull(_selectedImage);

      var response = await _paymentService.createPaymentForZeroInterestLoan(
          clientId: loan.clientId,
          loanId: loan.id,
          principalAmountPaid:
              double.parse(_principalAmountPaidController.text),
          date: DateTime.now(),
          receiptImageUrl: receiptImageUrl,
          description: _descriptionController.text);

      if (response.success) {
        return Right(Success());
      } else {
        return Left(CustomError.withMessage(response.message));
      }
    } else {
      return Right(Success());
    }
  }
}
