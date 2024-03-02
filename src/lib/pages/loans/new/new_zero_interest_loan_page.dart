import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/client/client_list_dropdown_menu_component.dart';
import 'package:pokinia_lending_manager/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/models/client.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';

class NewZerointerestLoanPage extends StatefulWidget {
  const NewZerointerestLoanPage({super.key});

  @override
  State<NewZerointerestLoanPage> createState() =>
      _NewZerointerestLoanPageState();
}

class _NewZerointerestLoanPageState extends State<NewZerointerestLoanPage> {
  bool _isProcessing = false;
  bool _isIndefinitely = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _expectedPayDate = DateTime.now();

  Client? _selectedClient;
  void _onClientSelected(client) {
    _selectedClient = client;
  }

  void setIsProcessing(bool value) {
    setState(() {
      _isProcessing = value;
    });
  }

  void _createLoan(BuildContext context, LoanService loanService) async {
    if (_formKey.currentState!.validate()) {
      setIsProcessing(true);

      var response = await loanService.createZeroInterestLoan(
          clientId: _selectedClient!.id,
          principalAmount: double.parse(_amountController.text),
          expectedPayDate: _isIndefinitely ? null : _expectedPayDate);

      setIsProcessing(false);

      if (response.succeeded) {
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body!),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _expectedPayDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _expectedPayDate) {
      setState(() {
        _expectedPayDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanService>(
      builder: (context, loanService, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('New Zero-interest Loan'),
          ),
          body: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: ClientListDropdownMenu(
                        controller: _clientController,
                        onClientSelected: _onClientSelected),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: MyTextFormField(
                        keyboardType: TextInputType.number,
                        labelText: "Principal amount",
                        validator: (value) {
                          if (value.isNullOrEmpty()) {
                            return "Principal amount can't be empty";
                          }

                          if (value.isNotNumeric()) {
                            return "Principal amount must be a number";
                          }

                          double doubleValue = double.parse(value!);

                          if (doubleValue <= 0) {
                            return "Principal amount must be greater than 0";
                          }

                          return null;
                        },
                        controller: _amountController),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ParagraphOneText(
                            text: 'No paydate (indefinitely): ',
                            fontWeight: FontWeight.bold),
                        CupertinoSwitch(
                            value: _isIndefinitely,
                            onChanged: (value) {
                              setState(() {
                                _isIndefinitely = value;
                              });
                            })
                      ],
                    ),
                  ),
                  if (_isIndefinitely == false)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ParagraphOneText(
                              text: 'Expected pay date: ',
                              fontWeight: FontWeight.bold),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: _isProcessing
                                      ? null
                                      : () => _selectDate(context),
                                  icon: const Icon(Icons.calendar_month)),
                              ParagraphOneText(
                                  text: _expectedPayDate.toFormattedDate()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: MyCtaButton(
                      isProcessing: _isProcessing,
                      text: "Create loan",
                      onPressed: () => _createLoan(context, loanService),
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
