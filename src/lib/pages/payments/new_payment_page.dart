import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/components/app_bars/my_app_bar.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/images/image_picker.dart';
import 'package:pokinia_lending_manager/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/enums/loan_types.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/models/data/loan_statement.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/services/receipt_service.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';

class NewPaymentPage extends StatefulWidget {
  final Loan loan;
  final LoanStatement? loanStatement;

  const NewPaymentPage({super.key, required this.loan, this.loanStatement});

  @override
  State<NewPaymentPage> createState() => _NewPaymentPageState();
}

class _NewPaymentPageState extends State<NewPaymentPage> {
  final Logger _logger = getLogger('NewPaymentPage');
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _interestAmountPaidController =
      TextEditingController();
  final TextEditingController _principalAmountPaidController =
      TextEditingController();
  File? _selectedImage;
  bool _isProcessing = false;
  late bool showInterests;

  @override
  void initState() {
    super.initState();
    if (widget.loan.type == LoanTypes.zeroInterestLoan) {
      showInterests = false;
    } else {
      showInterests = true;
    }
  }

  void _addPayment() async {
    if (_formKey.currentState!.validate()) {
      setOnProcessing(true);

      var paymentService = Provider.of<PaymentProvider>(context, listen: false);

      var urlDownload = "";
      if (_selectedImage != null) {
        urlDownload = await ReceiptService().uploadReceipt(_selectedImage!);
      }

      Response? response;

      if (widget.loan.type == LoanTypes.openEndedLoan) {
        response = await paymentService.createPaymentForOpenEndedLoan(
            clientId: widget.loan.clientId,
            loanId: widget.loan.id,
            loanStatementId: widget.loanStatement!.id,
            principalAmountPaid:
                double.parse(_principalAmountPaidController.text),
            interestAmountPaid:
                double.parse(_interestAmountPaidController.text),
            date: DateTime.now(),
            receiptImageUrl: urlDownload);
      } else if (widget.loan.type == LoanTypes.zeroInterestLoan) {
        response = await paymentService.createPaymentForZeroInterestLoan(
            clientId: widget.loan.clientId,
            loanId: widget.loan.id,
            principalAmountPaid:
                double.parse(_principalAmountPaidController.text),
            date: DateTime.now(),
            receiptImageUrl: urlDownload);
      }

      setOnProcessing(false);

      if (response!.succeeded) {
        Navigator.pop(context);
      } else {
        _logger.e(response.message);

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
            if (showInterests) _getInterestAmountWidget(),
            _getPrincipalAmountWidget(),
            const Spacer(),
            _getAddPaymentButtonWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getInterestAmountWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          keyboardType: TextInputType.number,
          enabled: !_isProcessing,
          labelText: "Interest amount paid",
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Interest amount paid can't be empty";
            }

            if (value.isNotNumeric()) {
              return "Interest amount paid must be a number";
            }
            return null;
          },
          controller: _interestAmountPaidController),
    );
  }

  Widget _getPrincipalAmountWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          keyboardType: TextInputType.number,
          enabled: !_isProcessing,
          labelText: "Principal amount paid",
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Principal amount paid can't be empty";
            }

            if (value.isNotNumeric()) {
              return "Principal amount paid must be a number";
            }
            return null;
          },
          controller: _principalAmountPaidController),
    );
  }

  Widget _getAddPaymentButtonWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: MyCtaButton(
        text: "Add payment",
        isProcessing: _isProcessing,
        onPressed: _isProcessing ? null : _addPayment,
      ),
    );
  }
}
