import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/data/models/currency_data_model.dart';
import 'package:pokinia_lending_manager/data/repositories/base_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/currency_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCurrencyRepository extends BaseRepository<CurrencyDataModel>
    with CurrencyRepository {
  SupabaseCurrencyRepository(SupabaseClient supabaseClient)
      : super(supabaseClient, DataRepositories.currencyRepository,
            TableNames.currencies, (data) => CurrencyDataModel.fromJson(data));

  @override
  Either<CustomError, List<CurrencyDataModel>> getAllCurrencies() {
    try {
      return Right(data);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  @override
  Either<CustomError, CurrencyDataModel> getCurrencyById(String id) {
    try {
      var currency = data.firstWhere((element) => element.id == id);
      return Right(currency);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
