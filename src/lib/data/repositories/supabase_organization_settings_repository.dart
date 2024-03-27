import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/organization_settings_parameters.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/data/models/organization_settings_data_model.dart';
import 'package:pokinia_lending_manager/data/repositories/base_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/organization_settings_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseOrganizationSettingsRepository
    extends BaseRepository<OrganizationSettingsDataModel>
    with OrganizationSettingsRepository {
  SupabaseOrganizationSettingsRepository(SupabaseClient supabaseClient)
      : super(
            supabaseClient,
            DataRepositories.organizationSettingsRepository,
            TableNames.organizationSettings,
            (data) => OrganizationSettingsDataModel.fromJson(data));

  @override
  OrganizationSettingsDataModel getOrganizationSetting(
      String organizationId, OrganizationSettingsParameters parameterKey) {
    var organizationSetting = data.firstWhere((element) =>
        element.organizationId == organizationId &&
        element.key == parameterKey.value);
    return organizationSetting;
  }

  @override
  Future<Response> updateParameter(String organizationId,
      OrganizationSettingsParameters parameterKey, String value) async {
    try {
      await supabaseClient
          .from('organization_settings')
          .update({'value': value.toString()})
          .eq('organization_id', organizationId)
          .eq('key', parameterKey.value);

      return Response.successWithMessage(message: 'Parameter updated successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }
}
