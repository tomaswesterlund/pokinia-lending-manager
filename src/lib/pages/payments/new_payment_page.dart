import 'dart:io';
import 'package:circular_image/circular_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/services/file_service.dart';
import 'package:pokinia_lending_manager/services/image_picker_service.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';

class NewPaymentPage extends StatefulWidget {
  final String clientId;
  final String loanId;
  final String loanStatementId;

  const NewPaymentPage(
      {super.key,
      required this.clientId,
      required this.loanId,
      required this.loanStatementId});

  @override
  State<NewPaymentPage> createState() => _NewPaymentPageState();
}

class _NewPaymentPageState extends State<NewPaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _interestAmountPaidController =
      TextEditingController();
  final TextEditingController _principalAmountPaidController =
      TextEditingController();
  File? _selectedImage;
  bool _isProcessing = false;

  void _addPayment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
      });

      var paymentService = Provider.of<PaymentService>(context, listen: false);

      var urlDownload = "";
      if (_selectedImage != null) {
        urlDownload = await FileService().uploadPaymentReceipt(_selectedImage!);
      }

      paymentService
          .createPayment(
              clientId: widget.clientId,
              loanId: widget.loanId,
              loanStatementId: widget.loanStatementId,
              interestAmountPaid:
                  double.parse(_interestAmountPaidController.text),
              principalAmountPaid:
                  double.parse(_principalAmountPaidController.text),
              date: DateTime.now(),
              receiptImagePath: urlDownload)
          .then(
        (value) {
          if (value.statusCode == 200) {
            setState(() {
              _isProcessing = false;
              Navigator.pop(context);
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please validate your input!"),
              ),
            );
          }
        },
      );
    }
  }

  Future _pickImage(ImageSource source) async {
    final returnedImage = await ImagePickerService().pickImage(source);

    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getHeaderWidget(),
          _getInterestAmountWidget(),
          _getPrincipalAmountWidget(),
          _getImagePickerWidget(),
          _getAddPaymentButtonWidget()
        ],
      ),
    );
  }

  Widget _getHeaderWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HeaderFourText(text: "Add payment"),
          IconButton(
              disabledColor: Colors.grey,
              onPressed: _isProcessing ? null : () => Navigator.pop(context),
              icon: const Icon(Icons.close))
        ],
      ),
    );
  }

  Widget _getInterestAmountWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          enabled: !_isProcessing,
          labelText: "Interest amount paid",
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Interest amount paid can't be empty";
            }

            if (value.isNotANumber()) {
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
          enabled: !_isProcessing,
          labelText: "Principal amount paid",
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Principal amount paid can't be empty";
            }

            if (value.isNotANumber()) {
              return "Principal amount paid must be a number";
            }
            return null;
          },
          controller: _principalAmountPaidController),
    );
  }

  Widget _getImagePickerWidget() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: ParagraphOneText(text: "Upload receipt image (optional)?"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () =>
                    _isProcessing ? null : _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo, size: 48.0)),
            const SizedBox(width: 20),
            IconButton(
                onPressed: () =>
                    _isProcessing ? null : _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt, size: 48.0)),
          ],
        ),
        if (_selectedImage != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: CircularImage(
                source: _selectedImage!.path,
                radius: 50,
                borderWidth: 2,
                borderColor: Colors.grey),
          )
        else
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: CircularImage(
                source: 'assets/images/empty_image.png',
                radius: 50,
                borderWidth: 2,
                borderColor: Colors.grey),
          ),
      ],
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
