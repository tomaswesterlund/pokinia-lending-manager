import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/parameters/new_open_ended_loan_parameters.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/domain/services/open_ended_loan_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class NewOpenEndedLoanPageViewModel extends BaseViewModel {
  final OpenEndedLoanService _openEndedLoanService;

  NewOpenEndedLoanPageViewModel(this._openEndedLoanService);

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController _clientController = TextEditingController();
  TextEditingController get clientController => _clientController;

  final TextEditingController _principalAmountController =
      TextEditingController();
  TextEditingController get principalAmountController =>
      _principalAmountController;

  final TextEditingController _interestRateController = TextEditingController();
  TextEditingController get interestRateController => _interestRateController;

  ClientEntity? _selectedClient;
  ClientEntity? get selectedClient => _selectedClient;
  void onClientSelected(ClientEntity? client) {
    _selectedClient = client;
    notifyListeners();
  }

  DateTime _startDate = DateTime.now();
  DateTime get startDate => _startDate;
  void onStartDateSelected(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  Future<Either<CustomError, Success>> createLoan(
      NewOpenEndedLoanParameters params) async {
    try {
      if (_formKey.currentState!.validate()) {
        state = States.processing;

        params.clientId = _selectedClient!.id;
        params.principalAmount = double.parse(_principalAmountController.text);
        params.interestRate = double.parse(_interestRateController.text);
        params.startDate = _startDate;
        params.generateLoanStatementsIntoTheFuture = 6;

        var response = await _openEndedLoanService.createLoan(params);

        state = States.ready;

        if (response.success) {
          return Right(Success());
        } else {
          return Left(CustomError.withMessage(response.message));
        }
      } else {
        return Right(Success());
      }
    } catch (e) {
      state = States.error;
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
