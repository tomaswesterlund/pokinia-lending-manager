import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/data/models/user_settings_data_model.dart';

mixin UserSettingsRepository {
  addListener(Function() onChangesNotifyListeners);

  List<UserSettingsDataModel> getAllUserSettings();

  UserSettingsDataModel getUserSettingsForLoggedInUser();

  Future<Response> updateShowDeletedClients(
      String userId, bool value);

  Future<Response> updateShowDeletedLoans(
      String userId, bool value);

  Future<Response> updateShowDeletedLoanStatements(
      String userId, bool value);

  Future<Response> updateShowDeletedPayments(
      String userId, bool value);
}
