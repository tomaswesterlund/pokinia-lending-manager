import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
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
  final TextEditingController _interestAmountPaidController =
      TextEditingController();
  final TextEditingController _principalAmountPaidController =
      TextEditingController();
  PlatformFile? _selectedFile;
  bool _isProcessing = false;

  void _addPayment() async {
    setState(() {
      _isProcessing = true;
    });

    var paymentService = Provider.of<PaymentService>(context, listen: false);

    var interestAmoudPaid = double.parse(_interestAmountPaidController.text);
    var principalAmountPaid = double.parse(_principalAmountPaidController.text);
    var date = DateTime.now();


    var urlDownload = "";
    if(_selectedFile != null) {
      urlDownload = await _uploadFile();
    }

    paymentService
        .createPayment(
            clientId: widget.clientId,
            loanId: widget.loanId,
            loanStatementId: widget.loanStatementId,
            interestAmountPaid: interestAmoudPaid,
            principalAmountPaid: principalAmountPaid,
            date: date,
            receiptImagePath: urlDownload)
        .then(
      (value) {
        if (value.statusCode == 200) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please validate your input!"),
            ),
          );
        }

        setState(() {
          _isProcessing = false;
        });
      },
    );
  }

  Future _selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = result.files.single;
      });
    }
  }

  Future<String> _uploadFile() async {
    final path = 'files/payment_receipts/${UniqueKey().toString()}.png';
    final file = File(_selectedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    var uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add payment"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: MyTextFormField(
                        labelText: "Interest amount paid",
                        validator: (value) {
                          return null;
                        },
                        controller: _interestAmountPaidController),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: MyTextFormField(
                        labelText: "Principal amount paid",
                        validator: (value) {
                          return null;
                        },
                        controller: _principalAmountPaidController),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: MyCtaButton(
                        text: "Select file", onPressed: _selectFile),
                  ),
                  if (_selectedFile != null)
                    Expanded(
                      child: Container(
                        color: Colors.blue,
                        child: Center(
                          child: Image.file(
                            File(_selectedFile!.path!),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                ],
              ),
              if (_isProcessing)
                const CircularProgressIndicator()
              else
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  child: MyCtaButton(
                      text: "Add payment",
                      onPressed: () {
                        _addPayment();
                      }),
                )
            ],
          ),
        ));
  }
}
