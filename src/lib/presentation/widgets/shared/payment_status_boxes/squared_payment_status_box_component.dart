import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_boxes/base_payment_status_box_component.dart';

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
