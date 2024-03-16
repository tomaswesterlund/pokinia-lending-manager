import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/app_bars/my_app_bar.dart';
import 'package:pokinia_lending_manager/components/images/image_picker.dart';
import 'package:pokinia_lending_manager/components/input/principal_amount_form_field.dart';
import 'package:pokinia_lending_manager/components/payments/form_fields/add_payment_button.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/services/log_service.dart';
import 'package:pokinia_lending_manager/services/receipt_service.dart';
import 'package:provider/provider.dart';

class NewZeroInterestLoanPaymentPage extends StatefulWidget {
  final String loanId;

  const NewZeroInterestLoanPaymentPage({super.key, required this.loanId});

  @override
  State<NewZeroInterestLoanPaymentPage> createState() =>
      _NewZeroInterestLoanPaymentPageState();
}

class _NewZeroInterestLoanPaymentPageState
    extends State<NewZeroInterestLoanPaymentPage> {
  final LogService _logger = LogService('NewPaymentPage');

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _principalAmountPaidController =
      TextEditingController();

  File? _selectedImage;
  bool _isProcessing = false;

  void addPayment(Loan loan) async {
    if (_formKey.currentState!.validate()) {
      setOnProcessing(true);

      var paymentService = Provider.of<PaymentProvider>(context, listen: false);

      var urlDownload = "";
      if (_selectedImage != null) {
        urlDownload = await ReceiptService().uploadReceipt(_selectedImage!);
      }

      var response = await paymentService.createPaymentForZeroInterestLoan(
          clientId: loan.clientId,
          loanId: loan.id,
          principalAmountPaid:
              double.parse(_principalAmountPaidController.text),
          date: DateTime.now(),
          receiptImageUrl: urlDownload);

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

  void onImageSelected(File image) {
    setState(() {
      _selectedImage = image;
    });
  }

  void setOnProcessing(bool newValue) {
    setState(() {
      _isProcessing = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoanProvider, PaymentProvider>(
      builder: (context, loanProvider, paymentProvider, _) {
        var loan = loanProvider.getById(widget.loanId);

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
                PrincipalAmountFormField(
                    controller: _principalAmountPaidController,
                    isProcessing: _isProcessing),
                const Spacer(),
                AddPaymentButton(
                    isProcessing: _isProcessing, onPressed: () => addPayment(loan))
              ],
            ),
          ),
        );
      },
    );
  }
}
