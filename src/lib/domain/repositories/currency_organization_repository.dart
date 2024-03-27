import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/data/models/currency_organization_data_model.dart';

mixin CurrencyOrganizationRepository {
  addListener(Function() onChangesNotifyListeners);

  Either<CustomError, List<CurrencyOrganizationDataModel>>
      getAllCurrencyOrganizations();

  Either<CustomError, CurrencyOrganizationDataModel>
      getCurrencyOrganizationById(String id);
}
