import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';

class DotPaymentStatus extends StatelessWidget {
  final PaymentStatus paymentStatus;
  const DotPaymentStatus({super.key, required this.paymentStatus});

  Color _getColor() {
    if (paymentStatus == PaymentStatus.paid) {
      return const Color(0xFF22C55E);
    } else if (paymentStatus == PaymentStatus.pending) {
      return const Color.fromARGB(255, 255, 185, 0);
    } else if (paymentStatus == PaymentStatus.overdue) {
      return const Color.fromARGB(255, 255, 0, 0);
    } else {
      return const Color.fromARGB(255, 0, 255, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getColor(),
      ),
    );
  }
}
