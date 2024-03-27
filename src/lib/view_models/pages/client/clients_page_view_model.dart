import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/domain/entities/user_settings_entity.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/domain/services/user_settings_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class ClientsPageViewModel extends BaseViewModel {
  final ClientService _clientService;
  final UserSettingsService _userSettingsService;

  final String title = 'Clients';

  bool showDeleted = true;

  ClientsPageViewModel(this._clientService, this._userSettingsService) {
    _clientService.addListener(notifyListeners);
  }

  Either<CustomError, List<ClientEntity>> getClients() {
    try {
      var clients = _clientService.getAllClients();
      return Right(clients);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

  Future<Either<CustomError, UserSettingsEntity>> getUserSettings() async {
    try {
      var userSettings =
          await _userSettingsService.getUserSettingsForLoggedInUser();
      return Right(userSettings);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
