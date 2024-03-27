import 'package:pokinia_lending_manager/core/enums/organization_settings_parameters.dart';
import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/data/models/organization_settings_data_model.dart';

mixin OrganizationSettingsRepository {
  OrganizationSettingsDataModel getOrganizationSetting(
      String organizationId, OrganizationSettingsParameters parameterKey);

  Future<Response> updateParameter(
      String organizationId, OrganizationSettingsParameters parameterKey, String value);
}
