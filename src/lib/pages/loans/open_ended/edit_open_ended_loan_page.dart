import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/providers/loans/open_ended_loan_provider.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/input/interest_rate_form_field.dart';
import 'package:provider/provider.dart';

class EditOpenEndedLoanPage extends StatefulWidget {
  final String loanId;
  const EditOpenEndedLoanPage({super.key, required this.loanId});

  @override
  State<EditOpenEndedLoanPage> createState() => _EditOpenEndedLoanPageState();
}

class _EditOpenEndedLoanPageState extends State<EditOpenEndedLoanPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _interestRateController = TextEditingController();

  final bool _isProcessing = false;

  final Map<PaymentStatus, bool> _values = {
    PaymentStatus.prompt: false,
    PaymentStatus.overdue: true,
    PaymentStatus.scheduled: true,
    PaymentStatus.deleted: false,
  };

  void _editLoan() async {
    if (_formKey.currentState!.validate()) {
      var openEndedLoanService =
          Provider.of<OpenEndedLoanProvider>(context, listen: false);

      var interestRate = double.parse(_interestRateController.text);
      var statuses =
          _values.entries.where((e) => e.value).map((e) => e.key.name).toList();

      var repsonse = await openEndedLoanService.editLoan(
          widget.loanId, interestRate, statuses);

      if (mounted) {
        if (repsonse.succeeded) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(repsonse.message)));
        }
      }
    }
  }

  void _onCheckboxSelected(PaymentStatus status, bool value) {
    setState(() {
      _values[status] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Open Ended Loan'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text('Edit Open Ended Loan'),
              InterestRateFormField(
                  controller: _interestRateController,
                  isProcessing: _isProcessing),
              const Text('Which payment statuses do you want to edit?'),
              ..._values.entries.map(
                (e) => CheckboxListTile(
                    title: Text(e.key.name.toString()),
                    value: e.value,
                    onChanged: (bool? value) =>
                        _onCheckboxSelected(e.key, value!)),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: MyCtaButton(text: "Edit loan", onPressed: _editLoan),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
