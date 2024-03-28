import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/input/interest_rate_form_field.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/open_ended/edit_open_ended_loan_page_view_model.dart';
import 'package:provider/provider.dart';

class EditOpenEndedLoanPage extends StatelessWidget {
  final String loanId;
  const EditOpenEndedLoanPage({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    return Consumer<EditOpenEndedLoanPageViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Edit Open Ended Loan'),
          ),
          body: Form(
            key: vm.formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text('Edit Open Ended Loan'),
                  InterestRateFormField(
                      controller: vm.interestRateController,
                      isProcessing: vm.isProcessing),
                  const Text('Which payment statuses do you want to edit?'),
                  ...vm.paymentStatusValues.entries.map(
                    (e) => CheckboxListTile(
                      title: Text(e.key.name.toString()),
                      value: e.value,
                      onChanged: (bool? newValue) => vm.onPaymentStatusSelected(e.key, newValue!),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child:
                        MyCtaButton(text: "Edit loan", onPressed: () => vm.editLoan(loanId)),
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
