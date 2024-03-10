import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';

enum PaymentStatusBoxTypes { compact, dot, squared, wide }

class BasePaymentStatusBox extends StatelessWidget {
  final PaymentStatus paymentStatus;
  final PaymentStatusBoxTypes type;

  const BasePaymentStatusBox(
      {super.key, required this.paymentStatus, required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case PaymentStatusBoxTypes.compact:
        return _getCompact();
      case PaymentStatusBoxTypes.dot:
        return _getDot();
      case PaymentStatusBoxTypes.squared:
        return _getSquare();
      case PaymentStatusBoxTypes.wide:
        return _getWide();
      default:
        return _getCompact();
    }
  }

  Widget _getCompact() {
    return Center(
      child: Container(
        width: 16.0,
        height: 16.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getPrimaryColor(),
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

  Widget _getDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getPrimaryColor(),
      ),
    );
  }

  Widget _getSquare() {
    return Container(
      width: 32.0,
      height: 32.0,
      decoration: BoxDecoration(
        color: _getSecondaryColor(),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: _getPrimaryColor(),
          width: 2.0,
        ),
      ),
      child: Center(
        child: Container(
          width: 16.0,
          height: 16.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getPrimaryColor(),
          ),
          child: Center(
            child: Icon(
              _getIcon(),
              color: _getSecondaryColor(),
              size: 12.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getWide() {
    return Container(
      width: 150,
      height: 25,
      decoration: BoxDecoration(
        color: _getSecondaryColor(),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: _getPrimaryColor(),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Text(
              toBeginningOfSentenceCase(paymentStatus.name),
              style: TextStyle(
                color: _getPrimaryColor(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Center(
              child: Container(
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getPrimaryColor(),
                ),
                child: Center(
                  child: Icon(
                    _getIcon(),
                    color: _getSecondaryColor(),
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

  Color _getPrimaryColor() {
    switch (paymentStatus) {
      case PaymentStatus.paid || PaymentStatus.prompt:
        return const Color(0xFF22C55E);
      case PaymentStatus.scheduled:
        return const Color(0xFF57878B);
      case PaymentStatus.overdue:
        return const Color(0xFFF99C16);
      case PaymentStatus.deleted:
        return const Color(0xFFEB5857);
      case PaymentStatus.unknown:
        return const Color(0xFF57878B);
      case PaymentStatus.empty:
        return const Color.fromARGB(202, 238, 238, 238);
      default:
        return Colors.black;
    }
  }

  Color _getSecondaryColor() {
    switch (paymentStatus) {
      case PaymentStatus.paid || PaymentStatus.prompt:
        return const Color(0xFFF0FFF6);
      case PaymentStatus.scheduled:
        return const Color(0xFFF3FBFC);
      case PaymentStatus.overdue:
        return const Color(0xFFFFF4E5);
        case PaymentStatus.deleted:
        return const Color(0xFFFFF0F0);
      case PaymentStatus.unknown:
        return const Color(0xFFF3FBFC);
      default:
        return const Color.fromARGB(255, 116, 115, 115);
    }
  }

  IconData _getIcon() {
    switch (paymentStatus) {
      case PaymentStatus.paid || PaymentStatus.prompt:
        return Icons.check;
      case PaymentStatus.scheduled:
        return Icons.schedule;
      case PaymentStatus.overdue:
        return Icons.warning;
      case PaymentStatus.deleted:
        return Icons.delete;
      case PaymentStatus.empty:
        return Icons.email;
      default:
        return Icons.question_mark;
    }
  }

  Color _getIconColor() {
    if (paymentStatus == PaymentStatus.deleted) {
      return const Color(0xFFFFF0F0);
    } else {
      return Colors.white;
    }
  }
}
