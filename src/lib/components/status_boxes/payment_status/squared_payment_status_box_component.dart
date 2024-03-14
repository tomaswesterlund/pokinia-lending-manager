import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/base_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';

class SquaredPaymentStatusBoxComponent extends StatelessWidget {
  final PaymentStatus paymentStatus;
  const SquaredPaymentStatusBoxComponent(
      {super.key, required this.paymentStatus});

  
  Widget _getEmptyWidget() {
    return const SizedBox(
      width: 32.0,
      height: 32.0,
    );
  }


  @override
  Widget build(BuildContext context) {
    if (paymentStatus == PaymentStatus.empty) {
      return _getEmptyWidget();
    } else {
      return BasePaymentStatusBox(paymentStatus: paymentStatus, type: PaymentStatusBoxTypes.squared);
    }
  }
}
