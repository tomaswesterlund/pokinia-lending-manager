import 'package:flutter/widgets.dart';
import 'package:pokinia_lending_manager/domain/services/toast_service.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/boxes/square_tile.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => ToastService()
            .showWarningToast('Apple sign in is not yet supported'),
        child: const SquareTile(imagePath: 'assets/images/apple.png'));
  }
}
