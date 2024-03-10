import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';

class ColoredPaymentStatusBox extends StatelessWidget {
  final PaymentStatus paymentStatus;
  final Widget child;
  const ColoredPaymentStatusBox(
      {super.key, required this.paymentStatus, required this.child});

  const ColoredPaymentStatusBox.withBoolean(
      {super.key, required bool isDeleted, required this.child})
      : paymentStatus =
            isDeleted ? PaymentStatus.deleted : PaymentStatus.prompt;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        // height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _fillCOlor,
          border: Border(
            bottom: BorderSide(
              color: _borderColor,
            ),
          ),
        ),
        child: child);
  }

  Color get _fillCOlor {
    switch (paymentStatus) {
      case PaymentStatus.paid:
        return const Color(0xFFF0FFF6);
      case PaymentStatus.prompt:
        return const Color(0xFFF0FFF6);
      case PaymentStatus.pending:
        return const Color(0xFFFFF3CD);
      case PaymentStatus.overdue:
        return const Color(0xFFFFF4E5);
      case PaymentStatus.deleted:
        return const Color(0xFFFFF0F0);
      default:
        return const Color(0xFFF8F8F8);
    }
  }

  Color get _borderColor {
    switch (paymentStatus) {
      case PaymentStatus.paid:
        return const Color(0xFF22C55E);
      case PaymentStatus.prompt:
        return const Color(0x8022C55E);
      case PaymentStatus.pending:
        return const Color(0xFFE9E9E9);
      case PaymentStatus.overdue:
        return const Color(0x80F99C16);
      case PaymentStatus.deleted:
        return const Color(0x80EB5857);
      default:
        return Colors.grey[300]!;
    }
  }
}
