import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/domain/services/loan/zero_interest_loan_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class NewZeroInterestLoanPageViewModel extends BaseViewModel {
  final ZeroInterestLoanService _zeroInterestLoanService;

  NewZeroInterestLoanPageViewModel(this._zeroInterestLoanService);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController _principalAmountController =
      TextEditingController();
  TextEditingController get principalAmountController =>
      _principalAmountController;

  bool _isIndefinitely = true;
  bool get isIndefinitely => _isIndefinitely;

  DateTime _expectedPayDate = DateTime.now();
  DateTime get expectedPayDate => _expectedPayDate;

  ClientEntity? _selectedClient;

  void onClientSelected(ClientEntity? client) {
    _selectedClient = client;
  }

  void onIsIndefinitelyChanged(bool value) {
    _isIndefinitely = value;
    notifyListeners();
  }

  void onExpectedPayDateSelected(DateTime date) {
    _expectedPayDate = date;
    notifyListeners();
  }

  Future<Either<CustomError, Success>> createLoan() async {
    try {
      if (_formKey.currentState!.validate()) {
        state = States.processing;

        var response = await _zeroInterestLoanService.createZeroInterestLoan(
            clientId: _selectedClient!.id,
            principalAmount: double.parse(_principalAmountController.text),
            expectedPayDate: _isIndefinitely ? null : _expectedPayDate);

        state = States.ready;
      }

      return Right(Success());
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
