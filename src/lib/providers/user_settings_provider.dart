import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/models/data/user_settings.dart';
import 'package:pokinia_lending_manager/services/log_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserSettingsProvider extends ChangeNotifier {
  final LogService _logger = LogService('UserSettingsProvider');
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
      _logger.e('getByUserId', e.toString());
      rethrow;
    }
  }

  UserSettings getByLoggedInUser() {
    try {
      var userId = supabase.auth.currentUser!.id;
      return getByUserId(userId);
    } catch (e) {
      _logger.e('getByLoggedInUser', e.toString());
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
      _logger.e('setSelectedOrganizationId', e.toString());
      rethrow;
    }
  }

  Future<Response> createUserSettings(
      String userId, String organizationId) async {
    try {
      _logger.i('createUserSettings', 'Creating user settings for user: $userId');

      await supabase.from('user_settings').insert({
        'user_id': userId,
        'selected_organization_id': organizationId,
      });

      return Response.success();
    } catch (e) {
      _logger.e('createUserSettings', 'Error creating user settings: $e');
      return Response.error(e.toString());
    }
  }

  void updateShowDeletedClients(String userId, bool value) async {
    try {
      await supabase.from('user_settings').update({
        'show_deleted_clients': value,
      }).eq('user_id', userId);
    } catch (e) {
      _logger.e('updateShowDeletedClients', e.toString());
      rethrow;
    }
  }

  void updateShowDeletedLoans(String userId, bool value) async {
    try {
      await supabase.from('user_settings').update({
        'show_deleted_loans': value,
      }).eq('user_id', userId);
    } catch (e) {
      _logger.e('updateShowDeletedLoans', e.toString());
      rethrow;
    }
  }

  void updateShowDeletedLoanStatements(String userId, bool value) async {
    try {
      await supabase.from('user_settings').update({
        'show_deleted_loan_statements': value,
      }).eq('user_id', userId);
    } catch (e) {
      _logger.e('updateShowDeletedLoanStatements', e.toString());
      rethrow;
    }
  }

  void updateShowDeletedPayments(String userId, bool value) async {
    try {
      await supabase.from('user_settings').update({
        'show_deleted_payments': value,
      }).eq('user_id', userId);
    } catch (e) {
      _logger.e('updateShowDeletedPayments', e.toString());
      rethrow;
    }
  }
}
