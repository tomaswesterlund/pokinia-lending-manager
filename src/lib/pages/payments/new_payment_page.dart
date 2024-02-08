import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/input/my_text_field.dart';
import 'package:pokinia_lending_manager/services/payment_service.dart';
import 'package:provider/provider.dart';

class NewPaymentPage extends StatefulWidget {
final String clientId;
  final String loanId;
  final String loanStatementId;

  const NewPaymentPage({super.key, required this.clientId, required this.loanId, required this.loanStatementId});

  @override
  State<NewPaymentPage> createState() => _NewPaymentPageState();
}

class _NewPaymentPageState extends State<NewPaymentPage> {
  final TextEditingController _interestAmountPaidController =
      TextEditingController();
  final TextEditingController _principalAmountPaidController =
      TextEditingController();
  bool _isProcessing = false;

  void _addPayment() {
    setState(() {
      _isProcessing = true;
    });

    var paymentService = Provider.of<PaymentService>(context, listen: false);

    var interestAmoudPaid = double.parse(_interestAmountPaidController.text);
    var principalAmountPaid = double.parse(_principalAmountPaidController.text);
    var date = DateTime.now();

    paymentService
        .createPayment(
            clientId: widget.clientId,
            loanId: widget.loanId,
            loanStatementId: widget.loanStatementId,
            interestAmountPaid: interestAmoudPaid,
            principalAmountPaid: principalAmountPaid,
            date: date)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add payment"),
        ),
        body: Center(
          child: Column(
            children: [
              MyTextField(
                  labelText: "Interest amount paid",
                  controller: _interestAmountPaidController),
              MyTextField(
                  labelText: "Principal amount paid",
                  controller: _principalAmountPaidController),
              const Text("Comprobante"),
              if (_isProcessing)
                const CircularProgressIndicator()
              else
                MyCtaButton(
                    text: "Add payment",
                    onPressed: () {
                      _addPayment();
                    })
            ],
          ),
        ));
  }
}
