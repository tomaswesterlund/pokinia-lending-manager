import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/enums/client_payment_status.dart';

class WideClientStatusBoxComponent extends StatelessWidget {
  final ClientPaymentStatus clientPaymentStatus;

  const WideClientStatusBoxComponent({super.key, required this.clientPaymentStatus});

  Color _getFillColor() {
    switch (clientPaymentStatus) {
      case ClientPaymentStatus.prompt:
        return const Color(0xFFF0FFF6);
      case ClientPaymentStatus.overdue:
        return const Color(0xFFFFF0F0);
      default:
        return const Color.fromARGB(202, 238, 238, 238);
    }
  }

  Color _getBorderColor() {
    switch (clientPaymentStatus) {
      case ClientPaymentStatus.prompt:
        return const Color(0xFF22C55E);
      case ClientPaymentStatus.overdue:
        return const Color(0xFFEB5857);
      default:
        return const Color.fromARGB(255, 116, 115, 115);
    }
  }

  IconData _getIcon() {
    switch (clientPaymentStatus) {
      case ClientPaymentStatus.prompt:
        return Icons.check;
      case ClientPaymentStatus.overdue:
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
            child: Text(clientPaymentStatus.name),
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
