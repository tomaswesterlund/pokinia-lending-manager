import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/client/client_list_dropdown_menu_component.dart';
import 'package:pokinia_lending_manager/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
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
  bool _isProcessing = false;
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

  void _addLoan() async {
    if (_selectedClient == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a client!"),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
      });

      var response = await _loanService.createLoan(
          clientId: _selectedClient!.id,
          initialPrincipalAmount: double.parse(_loanPrincipalAmountController.text),
          initialInterestRate: double.parse(_interestRateController.text),
          startDate: _startDate,
          paymentPeriod: 'monthly');

      setState(() {
        _isProcessing = false;
      });

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

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _getHeaderWidget(),
          _getClientDropDownWidget(),
          _getPrincipalAmountWidget(),
          _getInterestRateWidget(),
          _getExpectedPayDateWidget(),
          _getPaymentPeriodWidget(),
          _getAddLoanButtonWidget()
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
          const HeaderFourText(text: "Add loan"),
          IconButton(
              disabledColor: Colors.grey,
              onPressed: _isProcessing ? null : () => Navigator.pop(context),
              icon: const Icon(Icons.close))
        ],
      ),
    );
  }

  Widget _getClientDropDownWidget() {
    return ClientListDropdownMenu(
      selectedClient: widget.selectedClient,
      enabled: !_isProcessing,
      onClientSelected: onClientSelected,
      controller: _clientController,
    );
  }

  Widget _getPrincipalAmountWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          enabled: !_isProcessing,
          labelText: "Principal amount",
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Principal amount can't be empty";
            }

            if (value.isNotANumber()) {
              return "Principal amount must be a number";
            }
            return null;
          },
          controller: _loanPrincipalAmountController),
    );
  }

  Widget _getInterestRateWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: MyTextFormField(
          enabled: !_isProcessing,
          labelText: "Interest rate",
          validator: (value) {
            if (value.isNullOrEmpty()) {
              return "Interest rate can't be empty";
            }

            if (value.isNotANumber()) {
              return "Interest rate must be a number";
            }
            return null;
          },
          controller: _interestRateController),
    );
  }

  Widget _getExpectedPayDateWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: _isProcessing ? null : () => _selectDate(context),
            child: const Text('Select first expected payment date'),
          ),
          ParagraphTwoText(
              text: _startDate.toFormattedDate(), fontWeight: FontWeight.bold)
        ],
      ),
    );
  }

  Widget _getPaymentPeriodWidget() {
    return Padding(
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
    );
  }

  Widget _getAddLoanButtonWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: MyCtaButton(
        text: "Add loan",
        isProcessing: _isProcessing,
        onPressed: _isProcessing ? null : _addLoan,
      ),
    );
  }
}
