import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_boxes/base_payment_status_box_component.dart';

class CompactPaymentStatusBox extends StatelessWidget {
  final PaymentStatus paymentStatus;

  const CompactPaymentStatusBox({super.key, required this.paymentStatus});

  @override
  Widget build(BuildContext context) {
    return BasePaymentStatusBox(
        paymentStatus: paymentStatus, type: PaymentStatusBoxTypes.compact);
  }
}
