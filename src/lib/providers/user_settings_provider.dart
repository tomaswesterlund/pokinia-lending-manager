import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/models/data/user_settings.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserSettingsProvider extends ChangeNotifier {
  final Logger _logger = getLogger('UserSettingsService');
  final supabase = Supabase.instance.client;
  bool loaded = false;

  final List<UserSettings> _userSettingsList = [];

  void startListener(Function(String source) onLoaded) {
    supabase.from('user_settings').stream(primaryKey: ['id']).listen((data) {
      var list = data.map((map) => UserSettings.fromMap(map)).toList();

      _userSettingsList.clear();
      _userSettingsList.addAll(list);

      if (!loaded) {
        loaded = true;
        onLoaded('userSettingsService');
      }

      notifyListeners();
    });
  }

  void initializeUserSettings(String userId) {
    if (!hasUserSettingsForUser(userId)) {
      createUserSettings(userId, '');
    }
  }

  bool hasUserSettingsForUser(String userId) {
    return _userSettingsList
        .where((element) => element.userId == userId)
        .isNotEmpty;
  }

  UserSettings getByUserId(String userId) {
    try {
      return _userSettingsList
          .firstWhere((element) => element.userId == userId);
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  void setSelectedOrganizationId(String userId, String organizationId) async {
    try {
      var response = await supabase.from('user_settings').update({
        'selected_organization_id': organizationId,
      }).eq('user_id', userId);

      notifyListeners();
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<Response> createUserSettings(
      String userId, String organizationId) async {
    try {
      _logger.i('Creating user settings for user: $userId');

      await supabase.from('user_settings').insert({
        'user_id': userId,
        'selected_organization_id': organizationId,
      });

      return Response.success();
    } catch (e) {
      _logger.e('Error creating user settings: $e');
      return Response.error(e.toString());
    }
  }
}
