import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/buttons/my_cta_button.dart';

class AddPaymentButton extends StatelessWidget {
  final bool isProcessing;
  final void Function() onPressed;
  const AddPaymentButton(
      {super.key, required this.isProcessing, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: MyCtaButton(
        text: "Add payment",
        isProcessing: isProcessing,
        onPressed: isProcessing ? null : onPressed,
      ),
    );
  }
}
