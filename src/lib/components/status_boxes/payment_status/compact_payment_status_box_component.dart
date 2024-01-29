import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';

class CompactPaymentStatusBox extends StatelessWidget {
  final PaymentStatus paymentStatus;

  const CompactPaymentStatusBox({super.key, required this.paymentStatus});

  Color _getBackgroundColor() {
    switch (paymentStatus) {
      case PaymentStatus.paid:
        return const Color(0xFF22C55E);
      case PaymentStatus.scheduled:
        return const Color(0xFF57878B);
      case PaymentStatus.overdue:
        return const Color(0xFFEB5857);
      case PaymentStatus.deleted:
      return Colors.transparent;
        //return const Color(0xFF57878B);
      case PaymentStatus.empty:
        return const Color.fromARGB(202, 238, 238, 238);

      default:
        return Colors.black;
    }
  }

  IconData _getIcon() {
    switch (paymentStatus) {
      case PaymentStatus.paid:
        return Icons.check;
      case PaymentStatus.scheduled:
        return Icons.schedule;
      case PaymentStatus.overdue:
        return Icons.close;
      case PaymentStatus.deleted:
        return Icons.delete;
      case PaymentStatus.empty:
        return Icons.email;
      default:
        return Icons.question_mark;
    }
  }

  Color _getIconColor() {
    if(paymentStatus == PaymentStatus.deleted) {
      return Colors.grey;
    } else {
      return Colors.white;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 16.0,
        height: 16.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getBackgroundColor(),
        ),
        child: Center(
          child: Icon(
            _getIcon(),
            color: _getIconColor(),
            size: 12.0,
          ),
        ),
      ),
    );
  }
}
