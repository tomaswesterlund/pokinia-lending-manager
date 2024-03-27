import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/buttons/my_log_out_button.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/domain/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountSettings extends StatelessWidget {
  final AuthService _authService = AuthService();
  final SupabaseClient _supabase = Supabase.instance.client;

  AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account settings'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
                child: ParagraphTwoText(text: 'User email'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
                child: ParagraphTwoText(
                    text: _supabase.auth.currentUser?.email ?? ''),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 32.0),
            child: MyLogOutButton(
              onPressed: () {
                _authService.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
