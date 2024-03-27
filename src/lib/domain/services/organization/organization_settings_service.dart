import 'package:pokinia_lending_manager/core/enums/organization_settings_parameters.dart';
import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/domain/entities/organization_settings_entity.dart';
import 'package:pokinia_lending_manager/domain/repositories/organization_settings_repository.dart';

class OrganizationSettingsService {
  final OrganizationSettingsRepository _organizationSettingsRepository;

  OrganizationSettingsService(this._organizationSettingsRepository);

  OrganizationSettingsEntity getOrganizationSetting(
      String organizationId, OrganizationSettingsParameters parameterKey) {
    var data = _organizationSettingsRepository.getOrganizationSetting(
        organizationId, parameterKey);

    return OrganizationSettingsEntity.fromDataModel(data);
  }

  Future<Response> updateParameter(String organizationId,
      OrganizationSettingsParameters parameterKey, String value) async {
    return await _organizationSettingsRepository.updateParameter(
        organizationId, parameterKey, value);
  }
}
