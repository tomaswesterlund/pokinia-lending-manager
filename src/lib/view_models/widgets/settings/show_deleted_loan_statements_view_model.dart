import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/domain/services/user_settings_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class ShowDeletedLoanStatementsViewModel extends BaseViewModel {
  final UserSettingsService _userSettingsService;

  ShowDeletedLoanStatementsViewModel(this._userSettingsService);

  bool? _showDeletedLoanStatements;
  bool? get showDeletedLoanStatements => _showDeletedLoanStatements;

  Future getShowDeletedLoanStatements() async {
    try {
      super.state = States.loading;
      var userSettings =
          await _userSettingsService.getUserSettingsForLoggedInUser();

      _showDeletedLoanStatements = userSettings.showDeletedLoanStatements;

      super.state = States.ready;
    } catch (e) {
      super.state = States.error;
    }
  }

  Future<Either<CustomError, Success>> updateShowDeletedLoanStatements(
      bool value) async {
    try {
      super.state = States.loading;
      _userSettingsService.updateShowDeletedLoanStatements(value);

      super.state = States.ready;
      return Right(Success());
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
