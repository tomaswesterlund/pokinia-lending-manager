import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/base_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';

class WidePaymentStatusBoxComponent extends StatelessWidget {
  final PaymentStatus paymentStatus;

  const WidePaymentStatusBoxComponent({super.key, required this.paymentStatus});

  @override
  Widget build(BuildContext context) {
    return BasePaymentStatusBox(
        paymentStatus: paymentStatus, type: PaymentStatusBoxTypes.wide);
  }
}
