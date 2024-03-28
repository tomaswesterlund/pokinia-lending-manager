import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/widgets/auth/apple_sign_in_button.dart';
import 'package:pokinia_lending_manager/presentation/widgets/auth/google_sign_in_button.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/view_models/pages/auth/sign_in_page_view_model.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  static String routeName = '/sign_in';

  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInPageViewModel>(
      builder: (context, vm, _) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.grey[300],
            ),
            backgroundColor: Colors.grey[300],
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const HeaderTwoText(text: 'Pokinia Lending Manager'),
                  const SizedBox(height: 50),

                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),

                  const SizedBox(height: 50),

                  Text(
                    'Please choose how to login',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // google + apple sign in buttons
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GoogleSignInButton(),
                      SizedBox(width: 25),
                      AppleSignInButton()
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

  // @override
  // void initState() {
  //   super.initState();
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // }
