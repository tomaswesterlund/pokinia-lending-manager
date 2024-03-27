import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/domain/services/toast_service.dart';
import 'package:pokinia_lending_manager/presentation/widgets/payments/add_payment_button.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/images/image_picker.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/input/description_form_field.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/input/principal_amount_form_field.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/my_app_bar.dart';
import 'package:pokinia_lending_manager/view_models/pages/payments/new_zero_interest_loan_payment_page_view_model.dart';
import 'package:provider/provider.dart';

class NewZeroInterestLoanPaymentPage extends StatelessWidget {
  final String loanId;
  const NewZeroInterestLoanPaymentPage({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewZeroInterestLoanPaymentPageViewModel>(
      builder: (context, vm, _) {
        vm.reset();
        
        return Scaffold(
          appBar: MyAppBar(title: 'Add payment', isProcessing: vm.isProcessing),
          body: Form(
            key: vm.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyImagePicker(
                    title: 'Receipt',
                    isProcessing: vm.isProcessing,
                    onImageSelected: vm.onImageSelected),
                PrincipalAmountFormField(
                    controller: vm.principalAmountPaidController,
                    isProcessing: vm.isProcessing),
                DescriptionFormField(
                    controller: vm.descriptionController,
                    isProcessing: vm.isProcessing),
                const Spacer(),
                AddPaymentButton(
                  isProcessing: vm.isProcessing,
                  onPressed: () {
                    vm.createPayment(loanId).fold(
                          (error) => ToastService().showErrorToast(
                              'An unexpected error occurred and the payment could not be created ...'),
                          (success) => context.pop(),
                        );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
