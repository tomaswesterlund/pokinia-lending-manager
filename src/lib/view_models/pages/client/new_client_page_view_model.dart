import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/domain/services/user_settings_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class NewClientPageViewModel extends BaseViewModel {
  final ClientService _clientService;
  final UserSettingsService _userSettingsService;

  NewClientPageViewModel(this._clientService, this._userSettingsService) {
    _clientService.addListener(notifyListeners);
  }

  Future<Either<CustomError, Success>> createClient(String name,
      String? phoneNumber, String? address, String? avatarImagePath) async {
    try {
      super.state = States.processing;

      var userSettings =
          await _userSettingsService.getUserSettingsForLoggedInUser();

      await _clientService.createClient(
        organizationId: userSettings.selectedOrganzationId,
        name: name,
        phoneNumber: phoneNumber,
        address: address,
        avatarImagePath: avatarImagePath,
      );

      super.state = States.ready;

      return Right(Success());
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
