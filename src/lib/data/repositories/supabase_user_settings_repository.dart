import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/data/models/user_settings_data_model.dart';
import 'package:pokinia_lending_manager/data/repositories/base_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/user_settings_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUserSettingsRepository
    extends BaseRepository<UserSettingsDataModel> with UserSettingsRepository {
  SupabaseUserSettingsRepository(SupabaseClient supabaseClient)
      : super(
            supabaseClient,
            DataRepositories.userSettingsRepository,
            TableNames.userSettings,
            (data) => UserSettingsDataModel.fromJson(data));

  @override
  List<UserSettingsDataModel> getAllUserSettings() {
    return data;
  }

  @override
  UserSettingsDataModel getUserSettingsForLoggedInUser() {
    var userId = supabaseClient.auth.currentUser?.id;
    return data.firstWhere((element) => element.userId == userId);
  }

  @override
  Future<Response> updateShowDeletedClients(String userId, bool value) async {
    try {
      await supabaseClient
          .from(TableNames.userSettings.value)
          .update({'show_deleted_clients': value}).eq('user_id', userId);

      return Response.successWithMessage(
          message: 'Show deleted clients updated successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> updateShowDeletedLoanStatements(
      String userId, bool value) async {
    try {
      await supabaseClient.from(TableNames.userSettings.value).update(
          {'show_deleted_loan_statements': value}).eq('user_id', userId);

      return Response.successWithMessage(
          message: 'Show deleted loan statements updated successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> updateShowDeletedLoans(String userId, bool value) async {
    try {
      await supabaseClient
          .from(TableNames.userSettings.value)
          .update({'show_deleted_loans': value}).eq('user_id', userId);

      return Response.successWithMessage(
          message: 'Show deleted loans updated successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> updateShowDeletedPayments(String userId, bool value) async {
    try {
      await supabaseClient
          .from(TableNames.userSettings.value)
          .update({'show_deleted_payments': value}).eq('user_id', userId);

      return Response.successWithMessage(
          message: 'Show deleted payments updated successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }
  
  
}
