import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/core/models/parameters/new_open_ended_loan_parameters.dart';
import 'package:pokinia_lending_manager/domain/services/toast_service.dart';
import 'package:pokinia_lending_manager/presentation/pages/main_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/client/client_list_dropdown_menu.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/input/interest_rate_form_field.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/input/principal_amount_form_field.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/input/select_date_input.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/open_ended/new_open_ended_loan_page_view_model.dart';
import 'package:provider/provider.dart';

class NewOpenEndedLoanPage extends StatelessWidget {
  final NewOpenEndedLoanParameters params;
  const NewOpenEndedLoanPage({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewOpenEndedLoanPageViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Create open-ended loan'),
          ),
          body: Center(
            child: Form(
              key: vm.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: ClientListDropdownMenu(
                        onClientSelected: vm.onClientSelected),
                  ),
                  PrincipalAmountFormField(
                      controller: vm.principalAmountController,
                      isProcessing: vm.isProcessing),
                  InterestRateFormField(
                      controller: vm.interestRateController,
                      isProcessing: vm.isProcessing),
                  SelectDateInput(
                      title: 'Start date',
                      helpText: 'Select the start date of the loan. The loan statements will be generated from this date.',
                      onDateSelected: vm.onStartDateSelected,
                      isProcessing: vm.isProcessing),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: MyCtaButton(
                      text: "Create loan",
                      onPressed: () => vm.createLoan(params).fold(
                          (error) =>
                              ToastService().showErrorToast(error.message),
                          (success) {
                            context.popUntil(MainPage.routeName);
                          }),
                    ),
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
