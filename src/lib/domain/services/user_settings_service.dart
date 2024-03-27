import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/domain/entities/user_settings_entity.dart';
import 'package:pokinia_lending_manager/domain/repositories/user_settings_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserSettingsService {
  final SupabaseClient _supabaseClient;
  final UserSettingsRepository _userSettingsRepository;
  String get userId => _supabaseClient.auth.currentUser!.id;

  UserSettingsService(this._supabaseClient, this._userSettingsRepository);

  void addListener(Function() listener) {
    _userSettingsRepository.addListener(listener);
  }

  Future<List<UserSettingsEntity>> getAllUserSettings() async {
    var dataModels = _userSettingsRepository.getAllUserSettings();
    var userSettings = dataModels
        .map((dataModel) => UserSettingsEntity.fromDataModel(dataModel))
        .toList();

    return userSettings;
  }

  Future<UserSettingsEntity> getUserSettingsForLoggedInUser() async {
    var data = _userSettingsRepository.getUserSettingsForLoggedInUser();
    return UserSettingsEntity.fromDataModel(data);
  }

  Future<Response> updateShowDeletedClients(
          bool value) async =>
      await _userSettingsRepository.updateShowDeletedClients(userId, value);

  Future<Response> updateShowDeletedPayments(
          bool value) async =>
      await _userSettingsRepository.updateShowDeletedPayments(userId, value);

  Future<Response> updateShowDeletedLoans(
          bool value) async =>
      await _userSettingsRepository.updateShowDeletedLoans(userId, value);

  Future<Response> updateShowDeletedLoanStatements(
          bool value) async =>
      await _userSettingsRepository.updateShowDeletedLoanStatements(
          userId, value);

}
