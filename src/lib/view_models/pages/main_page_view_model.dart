import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/application_service.dart';
import 'package:pokinia_lending_manager/core/enums/states.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/entities/user_settings_entity.dart';
import 'package:pokinia_lending_manager/domain/services/user_settings_service.dart';

class MainPageViewModel extends ChangeNotifier {
  final ApplicationService _applicationService;
  final UserSettingsService _userSettingsService;

  States get state => _applicationService.state;

  MainPageViewModel(this._applicationService, this._userSettingsService);

  Future<Either<CustomError, UserSettingsEntity>> getUserSettingsForLoggedInUser() async {
    try {
      var userSettings = await _userSettingsService.getUserSettingsForLoggedInUser();
      return Right(userSettings);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }
}
