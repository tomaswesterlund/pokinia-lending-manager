import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/currency_entity.dart';
import 'package:pokinia_lending_manager/domain/services/currency_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class CurrencyListSelectorViewModel extends BaseViewModel {
  final CurrencyService _currencyService;

  CurrencyListSelectorViewModel(this._currencyService);

  Either<CustomError, List<CurrencyEntity>> getAllCurrencies() => _currencyService.getAllCurrencies();
  
}