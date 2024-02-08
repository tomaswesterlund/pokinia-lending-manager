import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';

class CompactClientPaymentStatusBoxComponent extends StatelessWidget {
  final PaymentStatus paymentStatus;
  const CompactClientPaymentStatusBoxComponent(
      {super.key, required this.paymentStatus});

  Color _getFillColor() {
    switch (paymentStatus) {
      case PaymentStatus.prompt:
        return const Color(0xFFF0FFF6);
      case PaymentStatus.overdue:
        return const Color(0xFFFFF0F0);
      default:
        return const Color.fromARGB(202, 238, 238, 238);
    }
  }

  Color _getBorderColor() {
    switch (paymentStatus) {
      case PaymentStatus.prompt:
        return const Color(0xFF22C55E);
      case PaymentStatus.overdue:
        return const Color(0xFFEB5857);
      default:
        return const Color.fromARGB(255, 116, 115, 115);
    }
  }

  IconData _getIcon() {
    switch (paymentStatus) {
      case PaymentStatus.prompt:
        return Icons.check;
      case PaymentStatus.overdue:
        return Icons.close;
      default:
        return Icons.question_mark;
    }
  }

  Widget _getEmptyWidget() {
    return const SizedBox(
      width: 32.0,
      height: 32.0,
    );
  }

  Widget _getWidgetBasedOnStatus() {
    return Container(
      width: 32.0,
      height: 32.0,
      decoration: BoxDecoration(
        color: _getFillColor(), // Change the background color as needed
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: _getBorderColor(), // Border color
          width: 2.0, // Border width
        ),
      ),
      child: Center(
        child: Container(
          width: 16.0,
          height: 16.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getBorderColor(),
          ),
          child: Center(
            child: Icon(
              _getIcon(),
              color: _getFillColor(),
              size: 12.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (paymentStatus == PaymentStatus.empty) {
      return _getEmptyWidget();
    } else {
      return _getWidgetBasedOnStatus();
    }
  }
}
