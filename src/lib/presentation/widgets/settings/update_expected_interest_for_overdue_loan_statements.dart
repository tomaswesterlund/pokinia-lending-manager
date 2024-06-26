import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/domain/services/toast_service.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/unexpected_error.dart';
import 'package:pokinia_lending_manager/view_models/widgets/settings/update_expected_interest_for_overdue_loan_statements_view_model.dart';
import 'package:provider/provider.dart';

class UpdateExpectedInterestForOverdueLoanStatements extends StatelessWidget {
  const UpdateExpectedInterestForOverdueLoanStatements({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateExpectedInterestForOverdueLoanStatementsViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (vm.hasError) {
          return const UnexpectedError();
        } else if (vm.isReady) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: ParagraphTwoText(
                      text:
                          'Update expected interest for overdue loan statements when value changes'),
                ),
                const SizedBox(width: 12),
                CupertinoSwitch(
                  value: vm.value,
                  onChanged: (newValue) async {
                    var result =
                        await vm.updateExpectedInterestForOverdueLoanStatements(
                            newValue);
                    result.fold(
                        (error) => ToastService()
                            .showErrorToast('Could not update settings'),
                        (success) => null);
                  },
                ),
              ],
            ),
          );
        } else {
          return const Text("State not implemented ...");
        }
      },
    );
  }
}
