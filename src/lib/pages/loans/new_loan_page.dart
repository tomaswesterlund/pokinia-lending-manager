import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/input/my_text_field.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:provider/provider.dart';

class NewLoanPage extends StatefulWidget {
  String? clientId;

  NewLoanPage({super.key, this.clientId});
  @override
  State<NewLoanPage> createState() => _NewLoanPageState();
}

class _NewLoanPageState extends State<NewLoanPage> {
  DateTime _startDate = DateTime.now();
  late LoanService _loanService;
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _loanPrincipalAmountController =
      TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();

  @override
  void initState() {
    _clientController.text = widget.clientId ?? '';
    super.initState();
  }

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
    var clientId = _clientController.text;
    var initialPrincipalAmount =
        double.parse(_loanPrincipalAmountController.text);
    var initialInterestRate = double.parse(_interestRateController.text);

    var response = await _loanService.createLoan(
        clientId: clientId,
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

  @override
  Widget build(BuildContext context) {
    _loanService = Provider.of<LoanService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Loan'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('New Loan Page for: ${widget.clientId}'),
          ),

          // Select Client
          MyTextField(labelText: "Client", controller: _clientController),

          // Loan amount
          MyTextField(
              labelText: "Principal loan mount",
              controller: _loanPrincipalAmountController),

          // Interest rate
          MyTextField(
              labelText: "Interest rate", controller: _interestRateController),

          // loanPaymentStatus - Have backend calculate it?
          // Remaining principal amount - Have backend calculate it?

          // *** IGNORE ///
          // interestAmountPaid - null
          // principalAmountPaid - null

          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Select date'),
          ),

          DropdownButton<String>(
            items: <String>['monthly', 'weekyl'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (_) {},
          ),

          MyCtaButton(text: "Create loan", onPressed: _createLoan)
        ],
      ),
    );
  }
}
