import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/domain/services/open_ended_loan_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class EditOpenEndedLoanPageViewModel extends BaseViewModel {
  final OpenEndedLoanService _openEndedLoanService;

  EditOpenEndedLoanPageViewModel(this._openEndedLoanService);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController _interestRateController = TextEditingController();
  TextEditingController get interestRateController => _interestRateController;

  final Map<PaymentStatus, bool> _paymentStatusValues = {
    PaymentStatus.prompt: false,
    PaymentStatus.overdue: true,
    PaymentStatus.scheduled: true,
    PaymentStatus.deleted: false,
  };

  Map<PaymentStatus, bool> get paymentStatusValues => _paymentStatusValues;

  void onPaymentStatusSelected(PaymentStatus paymentStatus, bool value) {
    _paymentStatusValues[paymentStatus] = value;
  }

  Future<Either<CustomError, Success>> editLoan(String loanId) async {
    if (_formKey.currentState!.validate()) {
      var interestRate = double.parse(_interestRateController.text);
      var statuses = paymentStatusValues.entries
          .where((e) => e.value)
          .map((e) => e.key.name)
          .toList();

      var response =
          await _openEndedLoanService.editLoan(loanId, interestRate, statuses);

      if (response.succeeded) {
        return Right(Success());
      } else {
        return Left(CustomError.withMessage(response.message));
      }
    } else {
      return Right(Success());
    }
  }
}
