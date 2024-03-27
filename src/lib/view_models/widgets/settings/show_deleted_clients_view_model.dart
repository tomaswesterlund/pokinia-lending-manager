import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/domain/services/user_settings_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class ShowDeletedClientsViewModel extends BaseViewModel {
  final UserSettingsService _userSettingsService;

  ShowDeletedClientsViewModel(this._userSettingsService) {
    _userSettingsService.addListener(notifyListeners);
  }

  bool? _showDeletedClients;
  bool? get showDeletedClients => _showDeletedClients;

  Future<bool> getDeletedClients() async {
    var userSettings =
        await _userSettingsService.getUserSettingsForLoggedInUser();

    _showDeletedClients = userSettings.showDeletedClients;

    return _showDeletedClients!;
  }

  // Future getDeletedClients() async {
  //   try {
  //     super.state = States.loading;
  //     var userSettings =
  //         await _userSettingsService.getUserSettingsForLoggedInUser();

  //     _showDeletedClients = userSettings.showDeletedClients;

  //     super.state = States.ready;
  //   } catch (e) {
  //     super.state = States.error;
  //   }
  // }

  Future<Either<CustomError, Success>> updateShowDeletedClients(
      bool value) async {
    try {
      _userSettingsService.updateShowDeletedClients(value);
      return Right(Success());
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
