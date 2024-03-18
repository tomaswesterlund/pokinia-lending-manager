import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/app_bars/my_app_bar.dart';
import 'package:pokinia_lending_manager/components/images/image_picker.dart';
import 'package:pokinia_lending_manager/components/input/description_form_field.dart';
import 'package:pokinia_lending_manager/components/input/principal_amount_form_field.dart';
import 'package:pokinia_lending_manager/components/payments/form_fields/add_payment_button.dart';
import 'package:pokinia_lending_manager/components/payments/form_fields/interest_amount_text_field.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/models/data/loan_statement.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/services/log_service.dart';
import 'package:pokinia_lending_manager/services/receipt_service.dart';
import 'package:provider/provider.dart';

class NewOpenEndedLoanPaymentPage extends StatefulWidget {
  final Loan loan;
  final LoanStatement? loanStatement;

  const NewOpenEndedLoanPaymentPage(
      {super.key, required this.loan, this.loanStatement});

  @override
  State<NewOpenEndedLoanPaymentPage> createState() => _NewOpenEndedLoanPaymentPage();
}

class _NewOpenEndedLoanPaymentPage extends State<NewOpenEndedLoanPaymentPage> {
  final LogService _logger = LogService('NewOpenEndedLoanPaymentPage');
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _interestAmountPaidController =
      TextEditingController();
  final TextEditingController _principalAmountPaidController =
      TextEditingController();
      final TextEditingController _descriptionController =
      TextEditingController();
  File? _selectedImage;
  bool _isProcessing = false;

  void _addPayment() async {
    if (_formKey.currentState!.validate()) {
      setOnProcessing(true);

      var paymentService = Provider.of<PaymentProvider>(context, listen: false);

      var urlDownload = "";
      if (_selectedImage != null) {
        urlDownload = await ReceiptService().uploadReceipt(_selectedImage!);
      }

      var response = await paymentService.createPaymentForOpenEndedLoan(
          clientId: widget.loan.clientId,
          loanId: widget.loan.id,
          loanStatementId: widget.loanStatement!.id,
          principalAmountPaid:
              double.parse(_principalAmountPaidController.text),
          interestAmountPaid: double.parse(_interestAmountPaidController.text),
          date: DateTime.now(),
          receiptImageUrl: urlDownload,
          description: _descriptionController.text);

      setOnProcessing(false);

      if (response.succeeded) {
        Navigator.pop(context);
      } else {
        _logger.e('_addPayment', response.message);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void setOnProcessing(bool newValue) {
    setState(() {
      _isProcessing = newValue;
    });
  }

  void onImageSelected(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Add payment', isProcessing: _isProcessing),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyImagePicker(
                title: 'Receipt',
                isProcessing: _isProcessing,
                onImageSelected: onImageSelected),
            
            InterestAmountTextField(controller: _interestAmountPaidController, isProcessing: _isProcessing),
            PrincipalAmountFormField(controller: _principalAmountPaidController, isProcessing: _isProcessing),
            DescriptionFormField(controller: _descriptionController, isProcessing: _isProcessing),
            const Spacer(),
            AddPaymentButton(isProcessing: _isProcessing, onPressed: _addPayment)
          ],
        ),
      ),
    );
  }

}
