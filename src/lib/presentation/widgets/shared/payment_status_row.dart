import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_boxes/wide_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/paragraphs/paragraph_two_text.dart';

class PaymentStatusRow extends StatelessWidget {
  final PaymentStatus paymentStatus;
  const PaymentStatusRow({super.key, required this.paymentStatus});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ParagraphTwoText(text: "Status"),
        const Spacer(),
        WidePaymentStatusBoxComponent(paymentStatus: paymentStatus)
      ],
    );
  }
}
