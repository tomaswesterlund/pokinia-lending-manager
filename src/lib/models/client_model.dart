import 'package:pokinia_lending_manager/components/enums/payment_status_enum.dart';
import 'package:pokinia_lending_manager/models/loan_model.dart';

class ClientModel {
  final String name;
  final String phoneNumber;
  final List<LoanModel> _loans = [];

  ClientModel({required this.name, required this.phoneNumber});

  // Getter
  List<LoanModel> get loans => _loans;
  PaymentStatus get paymentStatus {
    if (_loans.isEmpty) {
      return PaymentStatus.empty;
    } else {
      if (_loans.any((loan) => loan.paymentStatus == PaymentStatus.overdue)) {
        return PaymentStatus.overdue;
      } else if (_loans
          .any((loan) => loan.paymentStatus == PaymentStatus.pending)) {
        return PaymentStatus.pending;
      } else if (_loans
          .any((loan) => loan.paymentStatus == PaymentStatus.prompt)) {
        return PaymentStatus.prompt;
      }
    }

    throw Exception("No payment status found");
  }

  void addLoan(LoanModel loan) {
    _loans.add(loan);
  }
}
