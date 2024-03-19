import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_log_out_button.dart';
import 'package:pokinia_lending_manager/components/settings/update_expected_interest_for_overdue_loan_statements.dart';
import 'package:pokinia_lending_manager/components/settings/update_expected_interest_for_scheduled_loan_statements.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/providers/organization_settings_provider.dart';
import 'package:pokinia_lending_manager/providers/user_settings_provider.dart';
import 'package:pokinia_lending_manager/services/auth_service.dart';
import 'package:pokinia_lending_manager/services/toast_service.dart';
import 'package:provider/provider.dart';
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
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Consumer2<OrganizationSettingsProvider, UserSettingsProvider>(
        builder: (context, organizationSettingsProvider, userSettingsProvider,
            child) {
          var userId = _supabase.auth.currentUser!.id;
          var userSettings = userSettingsProvider.getByUserId(userId);

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
                child: Center(
                  child: HeaderThreeText(text: 'General'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ParagraphTwoText(text: 'Show deleted clients'),
                    CupertinoSwitch(
                      value: userSettings.showDeletedClients,
                      onChanged: (value) {
                        try {
                          userSettingsProvider.updateShowDeletedClients(
                              userId, value);
                        } catch (error) {
                          ToastService()
                              .showErrorToast('Could not update settings');
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ParagraphTwoText(text: 'Show deleted loans'),
                    CupertinoSwitch(
                      value: userSettings.showDeletedLoans,
                      onChanged: (value) {
                        try {
                          userSettingsProvider.updateShowDeletedLoans(
                              userId, value);
                        } catch (error) {
                          ToastService()
                              .showErrorToast('Could not update settings');
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ParagraphTwoText(text: 'Show deleted payments'),
                    CupertinoSwitch(
                      value: userSettings.showDeletedPayments,
                      onChanged: (value) {
                        try {
                          userSettingsProvider.updateShowDeletedPayments(
                              userId, value);
                        } catch (error) {
                          ToastService()
                              .showErrorToast('Could not update settings');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
                child: Center(
                  child: HeaderThreeText(text: 'Loan statements'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ParagraphTwoText(text: 'Show deleted loan statements'),
                    CupertinoSwitch(
                      value: userSettings.showDeletedLoanStatements,
                      onChanged: (value) {
                        try {
                          userSettingsProvider.updateShowDeletedLoanStatements(
                              userId, value);
                        } catch (error) {
                          ToastService()
                              .showErrorToast('Could not update settings');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const UpdateExpectedInterestForOverdueLoanStatements(),
              const UpdateExpectedInterestForScheduledLoanStatements(),
              const SizedBox(height: 32.0),
              const Padding(
                padding: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
                child: Center(
                  child: HeaderThreeText(text: 'Account'),
                ),
              ),
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
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 32.0),
                child: MyLogOutButton(
                  onPressed: () {
                    _authService.signOut();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
