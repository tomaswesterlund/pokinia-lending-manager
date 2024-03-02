import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/client/client_list_dropdown_menu_component.dart';
import 'package:pokinia_lending_manager/components/input/interest_rate_form_field.dart';
import 'package:pokinia_lending_manager/components/input/principal_amount_form_field.dart';
import 'package:pokinia_lending_manager/components/input/select_date_input.dart';
import 'package:pokinia_lending_manager/models/loans/new_open_ended_loan_parameters.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:provider/provider.dart';

class NewOpenEndedLoanPage extends StatefulWidget {
  final NewOpenEndedLoanParameters params;
  const NewOpenEndedLoanPage({super.key, required this.params});

  @override
  State<NewOpenEndedLoanPage> createState() => _NewOpenEndedLoanPageState();
}

class _NewOpenEndedLoanPageState extends State<NewOpenEndedLoanPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _principalAmountController =
      TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  // final TextEditingController _generateLoanStatementsIntoTheFutureController =
  //     TextEditingController();
  final bool _isProcessing = false;

  void _onClientSelected(client) {
    widget.params.client = client;
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      widget.params.startDate = date;
    });
  }

  void _createLoan(LoanService loanService) async {
    if (_formKey.currentState!.validate()) {
      widget.params.principalAmount =
          double.parse(_principalAmountController.text);
      widget.params.interestRate = double.parse(_interestRateController.text);
      widget.params.generateLoanStatementsIntoTheFuture = 6;

      await loanService.createOpenEndedLoan(widget.params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Open Ended Loan'),
      ),
      body: Center(
        child: Consumer<LoanService>(
          builder: (context, loanService, _) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: ClientListDropdownMenu(
                        controller: _clientController,
                        onClientSelected: _onClientSelected),
                  ),
                  PrincipalAmountFormField(
                      controller: _principalAmountController,
                      isProcessing: _isProcessing),
                  InterestRateFormField(
                      controller: _interestRateController,
                      isProcessing: _isProcessing),
                  // AutomaticallyGenerateLoanStatementsFormField(
                  //     controller: _generateLoanStatementsIntoTheFutureController,
                  //     isProcessing: _isProcessing),
                  SelectDateInput(
                      title: 'Start date',
                      helpText: "Test",
                      onDateSelected: _onDateSelected,
                      isProcessing: _isProcessing),

                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: MyCtaButton(
                        text: "Review payment table", onPressed: null),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: MyCtaButton(
                        text: "Create loan", onPressed: () => _createLoan(loanService)),
                  ),

                  // Payment table preview
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
