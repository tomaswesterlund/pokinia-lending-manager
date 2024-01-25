class PaymentModel {
  final int amount;
  final DateTime payDate;
  final double interestRate;

  const PaymentModel({required this.amount, required this.payDate, required this.interestRate});
}