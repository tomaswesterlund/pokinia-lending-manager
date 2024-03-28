import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/domain/services/toast_service.dart';
import 'package:pokinia_lending_manager/presentation/pages/main_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/client/client_list_dropdown_menu.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/input/principal_amount_form_field.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/input/select_date_input.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/zero_interest/new_zero_interest_loan_page_view_model.dart';
import 'package:provider/provider.dart';

class NewZerointerestLoanPage extends StatelessWidget {
  const NewZerointerestLoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewZeroInterestLoanPageViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Create zero-interest loan'),
          ),
          body: Center(
            child: Form(
              key: vm.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: ClientListDropdownMenu(
                        onClientSelected: vm.onClientSelected),
                  ),
                  PrincipalAmountFormField(
                      controller: vm.principalAmountController,
                      isProcessing: vm.isProcessing),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ParagraphOneText(
                            text: 'No paydate (indefinitely): ',
                            fontWeight: FontWeight.bold),
                        CupertinoSwitch(
                            value: vm.isIndefinitely,
                            onChanged: vm.onIsIndefinitelyChanged)
                      ],
                    ),
                  ),
                  if (vm.isIndefinitely == false)
                    SelectDateInput(
                        title: 'Expected pay date',
                        helpText:
                            'Select the expected pay date of the loan. The Payment Status (prompt, overdue etc.) will be based on this date).',
                        onDateSelected: vm.onExpectedPayDateSelected,
                        isProcessing: vm.isProcessing),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: MyCtaButton(
                      isProcessing: vm.isProcessing,
                      text: "Create loan",
                      onPressed: () {
                        vm.createLoan().fold(
                            (error) => ToastService().showErrorToast(
                                'An unexpected error occurred  when creating the loan.'),
                            (success) => context.popUntil(MainPage.routeName));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
