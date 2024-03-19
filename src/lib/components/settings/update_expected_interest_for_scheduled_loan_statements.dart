import 'package:flutter/cupertino.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/providers/organization_settings_provider.dart';
import 'package:pokinia_lending_manager/providers/user_settings_provider.dart';
import 'package:pokinia_lending_manager/services/toast_service.dart';
import 'package:provider/provider.dart';

class UpdateExpectedInterestForScheduledLoanStatements extends StatelessWidget {
  const UpdateExpectedInterestForScheduledLoanStatements({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<OrganizationSettingsProvider, UserSettingsProvider>(
      builder:
          (context, organizationSettingsProvider, userSettingsProvider, _) {
        var userSettings = userSettingsProvider.getByLoggedInUser();
        var setting = organizationSettingsProvider.getSetting(
            userSettings.selectedOrganzationId, 'CEIAFL01');
        var value = setting.value == 'true';

        return Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: ParagraphTwoText(
                    text:
                        'Update expected interest for scheduled loan statements when value changes'),
              ),
              const SizedBox(width: 12),
              CupertinoSwitch(
                value: value,
                onChanged: (newValue) {
                  try {
                    organizationSettingsProvider.updateCEIAFL01(
                        userSettings.selectedOrganzationId, newValue);
                  } catch (error) {
                    ToastService().showErrorToast('Could not update settings');
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
