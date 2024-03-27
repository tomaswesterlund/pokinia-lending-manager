import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/domain/services/user_settings_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class ShowDeletedLoansViewModel extends BaseViewModel {
  final UserSettingsService _userSettingsService;

  ShowDeletedLoansViewModel(this._userSettingsService);

  bool? _showDeletedLoans;
  bool? get showDeletedLoans => _showDeletedLoans;

  Future getShowDeletedLoans() async {
    try {
      super.state = States.loading;
      var userSettings =
          await _userSettingsService.getUserSettingsForLoggedInUser();

      _showDeletedLoans = userSettings.showDeletedLoans;

      super.state = States.ready;
    } catch (e) {
      super.state = States.error;
    }
  }

  Future<Either<CustomError, Success>> updateShowDeletedLoans(
      bool value) async {
    try {
      super.state = States.loading;
      _userSettingsService.updateShowDeletedLoans(value);

      super.state = States.ready;
      return Right(Success());
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
