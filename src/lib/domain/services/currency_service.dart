import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/currency_entity.dart';
import 'package:pokinia_lending_manager/domain/repositories/currency_organization_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/currency_repository.dart';

class CurrencyService {
  final CurrencyRepository _currencyRepository;
  final CurrencyOrganizationRepository _currencyOrganizationRepository;

  CurrencyService(
      this._currencyRepository, this._currencyOrganizationRepository);

  Either<CustomError, List<CurrencyEntity>> getAllCurrencies() {
    try {
      return _currencyRepository.getAllCurrencies().fold(
        (error) => Left(error),
        (currencies) {
          var entities = <CurrencyEntity>[];
          for (var currency in currencies) {
            var entity = CurrencyEntity.fromDataModel(currency);
            entities.add(entity);
          }
          return Right(entities);
        },
      );
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  // bool currencySelected(String currencyId) {
  //   return _currencyOrganizations.any((co) => co.currencyId == currencyId);
  // }

  // List<CurrencyListItem> getAllCurrencies() {
  //   var currencyListItems = <CurrencyListItem>[];
  //   for (var currency in _currencies) {
  //     bool selected = false;
  //     if (currencySelected(currency.id)) {
  //       selected = true;
  //     }

  //     currencyListItems.add(CurrencyListItem(
  //       id: currency.id,
  //       key: currency.key,
  //       name: currency.name,
  //       selected: selected,
  //     ));
  //   }

  //   return currencyListItems;
  // }

  // List<CurrencyListItem> getUsersSelectedCurrencies() {
  //   var currencyListItems = <CurrencyListItem>[];
  //   for (var currency in _currencies) {
  //     if (currencySelected(currency.id)) {
  //       currencyListItems.add(CurrencyListItem(
  //         id: currency.id,
  //         key: currency.key,
  //         name: currency.name,
  //         selected: true,
  //       ));
  //     }
  //   }

  //   return currencyListItems;
  // }

  // void updateSelectedCurrency(
  //     String organizationID, String currencyId, bool selected) async {
  //   try {
  //     if (selected) {
  //       _logger.i('updateSelectedCurrency', 'Adding currencyId $currencyId');

  //       await supabase.from('currency_organization').upsert(
  //         [
  //           {
  //             'organization_id': organizationID,
  //             'currency_id': currencyId,
  //           }
  //         ],
  //       );
  //     } else {
  //       _logger.i('updateSelectedCurrency', 'Removing currencyId $currencyId');

  //       await supabase
  //           .from('currency_organization')
  //           .delete()
  //           .eq('organization_id', organizationID)
  //           .eq('currency_id', currencyId);
  //     }

  //     notifyListeners();
  //   } catch (e) {
  //     _logger.e('updateSelectedCurrency', e.toString());
  //     rethrow;
  //   }
  // }
}
