import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/organization_setting.dart';
import 'package:pokinia_lending_manager/services/log_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrganizationSettingsProvider extends ChangeNotifier {
  final LogService _logger = LogService('OrganizationSettingsProvider');
  final supabase = Supabase.instance.client;
  bool loaded = false;

  final List<OrganizationSetting> _organizationSettings = [];
  List<OrganizationSetting> get organizationSettings => _organizationSettings;

  void startListener(Function(String source) onLoaded) {
    supabase
        .from('organization_settings')
        .stream(primaryKey: ['id']).listen(((List<Map<String, dynamic>> data) {
      var organizationSettings =
          data.map((map) => OrganizationSetting.fromMap(map)).toList();
      _organizationSettings.clear();
      _organizationSettings.addAll(organizationSettings);

      if (!loaded) {
        loaded = true;
        onLoaded('OrganizationSettingsProvider');
      }

      notifyListeners();
    })).onError((error, stackTrace) {
      _logger.e(
          'startListener', 'Error listening to organizations settings: $error');
    });
  }

  OrganizationSetting getSetting(String organizationId, String key) {
    var organizationSetting = _organizationSettings.firstWhere((element) =>
        element.organizationId == organizationId && element.key == key);
    return organizationSetting;
  }

  void updateCEIAFL01(String organizationId, bool value) async {
    try {
      var response = await supabase
          .from('organization_settings')
          .update({'value': value.toString()})
          .eq('organization_id', organizationId)
          .eq('key', 'CEIAFL01');
    } catch (e) {
      _logger.e('updateCEIAFL01', 'Error updating CEIAFL01: $e');
    }
  }

  void updateCEIAFL02(String organizationId, bool value) async {
    try {
      var response = await supabase
          .from('organization_settings')
          .update({'value': value.toString()})
          .eq('organization_id', organizationId)
          .eq('key', 'CEIAFL02');
    } catch (e) {
      _logger.e('updateCEIAFL02', 'Error updating CEIAFL02: $e');
    }
  }
}
