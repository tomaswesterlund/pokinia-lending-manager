import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/enums/organization_settings_parameters.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/core/models/success.dart';
import 'package:pokinia_lending_manager/domain/services/organization/organization_settings_service.dart';
import 'package:pokinia_lending_manager/domain/services/user_settings_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class UpdateExpectedInterestForOverdueLoanStatementsViewModel
    extends BaseViewModel {
  final OrganizationSettingsService _organizationSettingsService;
  final UserSettingsService _userSettingsService;

  UpdateExpectedInterestForOverdueLoanStatementsViewModel(
      this._organizationSettingsService, this._userSettingsService);

  String? _value;
  bool get value => _value == 'true' ? true : false;

  Future getParameterValue() async {
    try {
      super.state = States.loading;
      var userSettings =
          await _userSettingsService.getUserSettingsForLoggedInUser();

      var result = _organizationSettingsService.getOrganizationSetting(
          userSettings.selectedOrganzationId,
          OrganizationSettingsParameters
              .calculateExpectedInterestAmountForOverdueLoans);

      super.state = States.ready;
      _value = result.value;
    } catch (e) {
      super.state = States.error;
    }
  }

  Future<Either<CustomError, Success>>
      updateExpectedInterestForOverdueLoanStatements(bool newValue) async {
    try {
      super.state = States.loading;
      var userSettings =
          await _userSettingsService.getUserSettingsForLoggedInUser();

      var organizationId = userSettings.selectedOrganzationId;

      var response = await _organizationSettingsService.updateParameter(
          organizationId,
          OrganizationSettingsParameters
              .calculateExpectedInterestAmountForOverdueLoans,
          newValue.toString());

      super.state = States.ready;

      if (response.success) {
        return Right(Success());
      } else {
        return Left(CustomError.withMessage(response.message));
      }
    } catch (e) {
      super.state = States.error;
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
