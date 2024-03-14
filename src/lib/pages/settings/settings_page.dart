import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_log_out_button.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_five_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsPage extends StatelessWidget {
  final AuthService _authService = AuthService();
  final SupabaseClient _supabase = Supabase.instance.client;

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HeaderTwoText(text: 'Settings'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
            child: Center(
              child: HeaderFiveText(text: 'Account'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
                child: ParagraphTwoText(text: 'Email'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
                child: ParagraphTwoText(
                    text: _supabase.auth.currentUser?.email ?? ''),
              ),
            ],
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 32.0),
            child: MyLogOutButton(onPressed: () {
              _authService.signOut();
            }),
          ),

          // const Padding(
          //   padding: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
          //   child: Center(
          //     child: ParagraphOneText(text: 'F E E D B A C K'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
