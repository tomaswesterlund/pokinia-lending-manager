import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/enums/payment_status_enum.dart';

class RegularStatusBoxComponent extends StatelessWidget {
  final PaymentStatus paymentStatus;

  const RegularStatusBoxComponent({super.key, required this.paymentStatus});

  Color _getFillColor() {
    switch (paymentStatus) {
      case PaymentStatus.prompt:
        return Color(0xFFF0FFF6);
      case PaymentStatus.pending:
        return Color(0xFFFFF4E5);

      case PaymentStatus.overdue:
        return Color(0xFFFFF0F0);

      default:
        return Color.fromARGB(202, 238, 238, 238);
    }
  }

  Color _getBorderColor() {
    switch (paymentStatus) {
      case PaymentStatus.prompt:
        return Color(0xFF22C55E);
      case PaymentStatus.pending:
        return Color(0xFFF99C16);
      case PaymentStatus.overdue:
        return Color(0xFFEB5857);

      default:
        return Color.fromARGB(255, 116, 115, 115);
    }
  }

  IconData _getIcon() {
    switch (paymentStatus) {
      case PaymentStatus.prompt:
        return Icons.check;

      case PaymentStatus.pending:
        return Icons.warning;
      case PaymentStatus.overdue:
        return Icons.close;

      default:
        return Icons.question_mark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 25,
      decoration: BoxDecoration(
        color: _getFillColor(),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: _getBorderColor(),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Text(paymentStatus.toString()),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
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
          ),
        ],
      ),
    );
  }
}