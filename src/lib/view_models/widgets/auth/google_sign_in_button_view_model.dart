import 'package:either_dart/either.dart';
import 'package:pokinia_lending_manager/core/models/custom_error.dart';
import 'package:pokinia_lending_manager/domain/services/auth_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleSignInButtonViewModel extends BaseViewModel {
  final AuthService _authService;

  GoogleSignInButtonViewModel(this._authService);

  Future<Either<CustomError, AuthResponse>> signInWithGoogle() async {
    try {
      var response = await _authService.signInWithGoogle();
      return Right(response);
    } catch (e) {
      return Left(CustomError.withMessage(e.toString()));
    }
  }

}