import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/domain/entities/organization_entity.dart';
import 'package:pokinia_lending_manager/domain/repositories/organization_repository.dart';

class OrganizationService {
  final OrganizationRepository _organizationRepository;

  OrganizationService(this._organizationRepository);

  void addListener(Function() onChangesNotifyListeners) {
    _organizationRepository.addListener(onChangesNotifyListeners);
  }

  Either<CustomError, OrganizationEntity> getOrganizationById(String id) {
    try {
      return _organizationRepository.getOrganizationById(id).fold(
        (error) {
          return Left(error);
        },
        (data) {
          var model = OrganizationEntity.fromDataModel(data);
          return Right(model);
        },
      );
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  Future<Either<CustomError, Success>> createOrganization(String name) async =>
      await _organizationRepository.createOrganization(name);
}
