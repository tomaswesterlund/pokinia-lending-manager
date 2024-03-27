import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/data/models/currency_data_model.dart';

mixin CurrencyRepository {
  addListener(Function() onChangesNotifyListeners);

  Either<CustomError, List<CurrencyDataModel>> getAllCurrencies();

  Either<CustomError, CurrencyDataModel> getCurrencyById(String id);
}
