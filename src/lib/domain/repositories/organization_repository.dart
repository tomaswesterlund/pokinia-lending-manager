import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/data/models/organization_data_model.dart';

mixin OrganizationRepository {
  addListener(Function() onChangesNotifyListeners);

  Either<CustomError, List<OrganizationDataModel>> getOrganizations();

  Either<CustomError, OrganizationDataModel> getOrganizationById(String id);

  Future<Either<CustomError, Success>> createOrganization(String name);
}
