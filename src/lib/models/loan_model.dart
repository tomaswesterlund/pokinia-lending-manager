import 'package:pokinia_lending_manager/components/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/payment_model.dart';

class LoanModel {
  final int amount;
  final double interestRate;

  List<PaymentModel> payments = [];
  List<PaymentModel> scheduledPayments = [];

  LoanModel({required this.amount, required this.interestRate});

  void addScheduledPayment(PaymentModel payment) {
    scheduledPayments.add(payment);
  }

  PaymentStatus get paymentStatus {
    if (scheduledPayments.isEmpty) {
      return PaymentStatus.empty;
    } else {
      var lastPayment = scheduledPayments.last;

      if (lastPayment.payDate.isBefore(DateTime.now())) {
        return PaymentStatus.overdue;
      } else if (lastPayment.payDate.isAfter(DateTime.now()) &&
          lastPayment.payDate.isBefore(DateTime.now().add(const Duration(days: 3)))) {
        return PaymentStatus.pending;
      } else if (lastPayment.payDate.isAfter(DateTime.now())) {
        return PaymentStatus.prompt;
      } else {
        throw Exception("No payment status found");
      }
    }
  }
}
