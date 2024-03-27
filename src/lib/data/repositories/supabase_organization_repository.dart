import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/data/models/organization_data_model.dart';
import 'package:pokinia_lending_manager/data/repositories/base_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/organization_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseOrganizationRepository
    extends BaseRepository<OrganizationDataModel> with OrganizationRepository {
  SupabaseOrganizationRepository(SupabaseClient supabaseClient)
      : super(
            supabaseClient,
            DataRepositories.organizationRepository,
            TableNames.organizations,
            (data) => OrganizationDataModel.fromJson(data));

  @override
  Either<CustomError, List<OrganizationDataModel>> getOrganizations() {
    try {
      return Right(data);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  @override
  Either<CustomError, OrganizationDataModel> getOrganizationById(String id) {
    try {
      var organization = data.firstWhere((element) => element.id == id);
      return Right(organization);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  @override
  Future<Either<CustomError, Success>> createOrganization(String name) async {
    try {
      var data = await supabaseClient.from('organizations').insert({
        'name': name,
      }).select('id');

      return Right(Success());
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
