import 'package:either_dart/either.dart';
import 'package:flutter/widgets.dart';
import 'package:pokinia_lending_manager/domain/services/toast_service.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/boxes/square_tile.dart';
import 'package:pokinia_lending_manager/view_models/widgets/auth/google_sign_in_button_view_model.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleSignInButtonViewModel>(
      builder: (context, vm, _) {
        return GestureDetector(
            onTap: () async {
              vm.signInWithGoogle().fold(
                  (error) => ToastService().showErrorToast(
                      'Something seems to have gone wrong, please try again.'),
                  (right) => null);
            },
            child: const SquareTile(imagePath: 'assets/images/google.png'));
      },
    );
  }
}
