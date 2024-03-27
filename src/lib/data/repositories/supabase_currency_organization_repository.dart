import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/data/models/currency_organization_data_model.dart';
import 'package:pokinia_lending_manager/data/repositories/base_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/currency_organization_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCurrencyOrganizationRepository
    extends BaseRepository<CurrencyOrganizationDataModel>
    with CurrencyOrganizationRepository {
  SupabaseCurrencyOrganizationRepository(SupabaseClient supabaseClient)
      : super(
            supabaseClient,
            DataRepositories.currencyOrganizationRepository,
            TableNames.currencies,
            (data) => CurrencyOrganizationDataModel.fromJson(data));

  @override
  Either<CustomError, List<CurrencyOrganizationDataModel>>
      getAllCurrencyOrganizations() {
    try {
      return Right(data);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  @override
  Either<CustomError, CurrencyOrganizationDataModel>
      getCurrencyOrganizationById(String id) {
    try {
      return Right(data.firstWhere((element) => element.id == id));
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
