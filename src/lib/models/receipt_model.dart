class ReceiptModel {
  final String id;
  final String paymentId;
  final String loanId;
  final String clientId;
  final DateTime date;
  final double interestPayment;
  final double principalPayment;
  final List<String> pathsToReceipt = [];

  ReceiptModel({
    required this.id,
    required this.paymentId,
    required this.loanId,
    required this.clientId,
    required this.date,
    required this.interestPayment,
    required this.principalPayment,
  });

  double get totalAmountPaid => interestPayment + principalPayment;
}
