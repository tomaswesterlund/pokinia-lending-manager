import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/client/client_list_dropdown_menu_component.dart';
import 'package:pokinia_lending_manager/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';

class NewLoanPage extends StatefulWidget {
  final ClientModel? selectedClient;

  const NewLoanPage({super.key, this.selectedClient});

  @override
  State<NewLoanPage> createState() => _NewLoanPageState();
}

class _NewLoanPageState extends State<NewLoanPage> {
  DateTime _startDate = DateTime.now();
  late LoanService _loanService;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _loanPrincipalAmountController =
      TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  ClientModel? _selectedClient;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  void _createLoan() async {
    if (_selectedClient == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a client!"),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      var initialPrincipalAmount =
          double.parse(_loanPrincipalAmountController.text);
      var initialInterestRate = double.parse(_interestRateController.text);

      var response = await _loanService.createLoan(
          clientId: _selectedClient!.id,
          initialPrincipalAmount: initialPrincipalAmount,
          initialInterestRate: initialInterestRate,
          startDate: _startDate,
          paymentPeriod: 'monthly');

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please validate your input!"),
          ),
        );
      }
    }
  }

  void onClientSelected(ClientModel? client) {
    _selectedClient = client;
  }

  @override
  Widget build(BuildContext context) {
    _loanService = Provider.of<LoanService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Loan'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ClientListDropdownMenu(
                  selectedClient: widget.selectedClient,
                  onClientSelected: onClientSelected,
                  controller: _clientController,
                ),

                // Loan amount
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: MyTextFormField(
                      labelText: "Principal loan amount",
                      validator: (value) {
                        if (value == null) {
                          return "A principal amount is required";
                        }

                        if (value.isEmpty) {
                          return "A principal amount is required";
                        }

                        if (value.isNumeric() == false) {
                          return "The value must be a number";
                        }

                        return null;
                      },
                      controller: _loanPrincipalAmountController,
                      keyboardType: TextInputType.number),
                ),

                // Interest rate
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: MyTextFormField(
                      labelText: "Interest rate",
                      validator: (value) {
                        if (value == null) {
                          return "A principal amount is required";
                        }

                        if (value.isEmpty) {
                          return "A principal amount is required";
                        }

                        if (value.isNumeric() == false) {
                          return "The value must be a number";
                        }

                        return null;
                      },
                      controller: _interestRateController),
                ),

                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: const Text('Select first expected payment date'),
                        ),
                        ParagraphTwoText(
                            text: _startDate.toFormattedDate(),
                            fontWeight: FontWeight.bold)
                      ],
                    )),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: DropdownButton<String>(
                    items: <String>['monthly', 'weekly'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: MyCtaButton(text: "Create loan", onPressed: _createLoan),
            )
          ],
        ),
      ),
    );
  }
}
