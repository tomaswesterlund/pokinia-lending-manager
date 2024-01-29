// import 'package:flutter/material.dart';
// import 'package:pokinia_lending_manager/models/payment_model.dart';
// import 'package:pokinia_lending_manager/providers/receipt_provider.dart';

// class PaymentProvider extends ChangeNotifier {
//   final ReceiptProvider receiptProvider;
//   final List<PaymentModel> _payments = [];

//   PaymentProvider({required this.receiptProvider}) {
//     // Habibi - Loan one
//     _payments.add(PaymentModel(
//       id: 'habibi_loan_one_payment_one',
//       loanId: 'habibi_loan_one',
//       clientId: 'habibi',
//       expectedInterestAmount: 25000,
//       expectedPrincipalAmount: 0,
//       interestRate: 5,
//       actualPayDate: DateTime(2023, 06, 30),
//       expectedPayDate: DateTime(2023, 06, 30),
//     ));

//     _payments.add(PaymentModel(
//       id: UniqueKey().toString(),
//       loanId: 'habibi_loan_one_payment_two',
//       clientId: 'habibi',
//       expectedInterestAmount: 25000,
//       expectedPrincipalAmount: 0,
//       interestRate: 5,
//       actualPayDate: DateTime(2023, 07, 31),
//       expectedPayDate: DateTime(2023, 07, 31),
//     ));

//     _payments.add(PaymentModel(
//       id: 'habibi_loan_one_payment_three',
//       loanId: 'habibi_loan_one',
//       clientId: 'habibi',
//       expectedInterestAmount: 15000,
//       expectedPrincipalAmount: 0,
//       interestRate: 3,
//       actualPayDate: DateTime(2023, 08, 30),
//       expectedPayDate: DateTime(2023, 08, 30),
//     ));

//     _payments.add(PaymentModel(
//       id: UniqueKey().toString(),
//       loanId: 'habibi_loan_one_payment_four',
//       clientId: 'habibi',
//       expectedInterestAmount: 15000,
//       expectedPrincipalAmount: 0,
//       interestRate: 3,
//       actualPayDate: DateTime(2023, 09, 30),
//       expectedPayDate: DateTime(2023, 09, 30),
//     ));

//     _payments.add(PaymentModel(
//       id: 'habibi_loan_one_payment_five',
//       loanId: 'habibi_loan_one',
//       clientId: 'habibi',
//       expectedInterestAmount: 15000,
//       expectedPrincipalAmount: 0,
//       interestRate: 3,
//       actualPayDate: DateTime(2023, 10, 31),
//       expectedPayDate: DateTime(2023, 10, 31),
//     ));

//     // _payments.add(PaymentModel(
//     //   id: UniqueKey().toString(),
//     //   loanId: 'habibi_loan_one',
//     //   clientId: 'habibi',
//     //   expectedInterestAmount: 15000,
//     //   expectedPrincipalAmount: 0,
//     //   interestRate: 3,
//     //   actualPayDate: DateTime(2023, 11, 30),
//     //   expectedPayDate: DateTime(2023, 11, 30),
//     // ));

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_one',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 15000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 3,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2023, 12, 31),
//     //   )
//     //     ..deleteDate = DateTime(2024, 01, 25)
//     //     ..deleteReason = "Cancelled",
//     // );

//     // _payments.add(PaymentModel(
//     //   id: UniqueKey().toString(),
//     //   loanId: 'habibi_loan_one',
//     //   clientId: 'habibi',
//     //   expectedInterestAmount: 10000,
//     //   expectedPrincipalAmount: 0,
//     //   interestRate: 2,
//     //   actualPayDate: null,
//     //   expectedPayDate: DateTime(2024, 01, 31),
//     // ));

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_one',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 10000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 2,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2024, 02, 29),
//     //   ),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_one',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 10000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 2,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2024, 03, 31),
//     //   ),
//     // );

//     // Habibi - Loan two
//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_two',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 25000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 5,
//     //     actualPayDate: DateTime(2023, 09, 15),
//     //     expectedPayDate: DateTime(2023, 09, 15),
//     //   )..transactions.add(ReceiptModel(
//     //       id: UniqueKey().toString(),
//     //       date: DateTime(2023, 09, 15),
//     //       principalPayment: 0,
//     //       interestPayment: 15000)),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_two',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 25000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 5,
//     //     actualPayDate: DateTime(2023, 10, 15),
//     //     expectedPayDate: DateTime(2023, 10, 15),
//     //   )..transactions.add(ReceiptModel(
//     //       id: UniqueKey().toString(),
//     //       date: DateTime(2023, 10, 15),
//     //       principalPayment: 0,
//     //       interestPayment: 15000)),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_two',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 25000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 5,
//     //     actualPayDate: DateTime(2023, 11, 15),
//     //     expectedPayDate: DateTime(2023, 11, 15),
//     //   )..transactions.add(ReceiptModel(
//     //       id: UniqueKey().toString(),
//     //       date: DateTime(2023, 11, 30),
//     //       principalPayment: 0,
//     //       interestPayment: 15000)),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_two',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 25000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 5,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2023, 12, 15),
//     //   )
//     //     ..deleteDate = DateTime(2024, 01, 25)
//     //     ..deleteReason = "Cancelled",
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_two',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 10000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 2,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2024, 01, 15),
//     //   )..transactions.add(ReceiptModel(
//     //       id: UniqueKey().toString(),
//     //       date: DateTime(2024, 01, 25),
//     //       principalPayment: 0,
//     //       interestPayment: 5000)),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_two',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 10000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 2,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2024, 02, 15),
//     //   ),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_two',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 10000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 2,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2024, 03, 15),
//     //   ),
//     // );

//     // // Habibi - Loan three
//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_three',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 10000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 2,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2024, 01, 20),
//     //   )..transactions.add(ReceiptModel(
//     //       id: UniqueKey().toString(),
//     //       date: DateTime(2024, 01, 25),
//     //       principalPayment: 0,
//     //       interestPayment: 5000)),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_three',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 10000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 2,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2024, 02, 20),
//     //   ),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_three',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 10000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 2,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2024, 03, 20),
//     //   ),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'habibi_loan_three',
//     //     clientId: 'habibi',
//     //     expectedInterestAmount: 10000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 2,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2024, 04, 20),
//     //   ),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'shay_loan_one',
//     //     clientId: 'shay',
//     //     expectedInterestAmount: 300000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 10,
//     //     actualPayDate: DateTime(2023, 01, 01),
//     //     expectedPayDate: DateTime(2023, 01, 01),
//     //   )..transactions.add(ReceiptModel(
//     //       id: UniqueKey().toString(),
//     //       date: DateTime(2023, 01, 01),
//     //       principalPayment: 0,
//     //       interestPayment: 300000)),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'shay_loan_one',
//     //     clientId: 'shay',
//     //     expectedInterestAmount: 300000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 10,
//     //     actualPayDate: DateTime(2023, 03, 01),
//     //     expectedPayDate: DateTime(2023, 03, 01),
//     //   )..transactions.add(ReceiptModel(
//     //       id: UniqueKey().toString(),
//     //       date: DateTime(2023, 03, 01),
//     //       principalPayment: 500000,
//     //       interestPayment: 300000)),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'shay_loan_one',
//     //     clientId: 'shay',
//     //     expectedInterestAmount: 75000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 3,
//     //     actualPayDate: DateTime(2023, 04, 01),
//     //     expectedPayDate: DateTime(2023, 04, 01),
//     //   )..transactions.add(ReceiptModel(
//     //       id: UniqueKey().toString(),
//     //       date: DateTime(2023, 04, 01),
//     //       principalPayment: 0,
//     //       interestPayment: 75000)),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'shay_loan_one',
//     //     clientId: 'shay',
//     //     expectedInterestAmount: 75000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 3,
//     //     actualPayDate: DateTime(2023, 05, 01),
//     //     expectedPayDate: DateTime(2023, 05, 01),
//     //   )..transactions.add(ReceiptModel(
//     //       id: UniqueKey().toString(),
//     //       date: DateTime(2023, 05, 01),
//     //       principalPayment: 0,
//     //       interestPayment: 75000)),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'shay_loan_one',
//     //     clientId: 'shay',
//     //     expectedInterestAmount: 75000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 3,
//     //     actualPayDate: DateTime(2023, 06, 01),
//     //     expectedPayDate: DateTime(2023, 06, 01),
//     //   )..transactions.add(ReceiptModel(
//     //       id: UniqueKey().toString(),
//     //       date: DateTime(2023, 06, 01),
//     //       principalPayment: 0,
//     //       interestPayment: 75000)),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'shay_loan_one',
//     //     clientId: 'shay',
//     //     expectedInterestAmount: 75000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 3,
//     //     actualPayDate: DateTime(2023, 07, 01),
//     //     expectedPayDate: DateTime(2023, 07, 01),
//     //   )..transactions.add(ReceiptModel(
//     //       id: UniqueKey().toString(),
//     //       date: DateTime(2023, 07, 01),
//     //       principalPayment: 0,
//     //       interestPayment: 75000)),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'shay_loan_one',
//     //     clientId: 'shay',
//     //     expectedInterestAmount: 75000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 3,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2023, 08, 01),
//     //   ),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'shay_loan_one',
//     //     clientId: 'shay',
//     //     expectedInterestAmount: 75000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 3,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2023, 09, 01),
//     //   ),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'shay_loan_one',
//     //     clientId: 'shay',
//     //     expectedInterestAmount: 75000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 3,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2023, 10, 01),
//     //   ),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'shay_loan_one',
//     //     clientId: 'shay',
//     //     expectedInterestAmount: 75000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 3,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2023, 11, 01),
//     //   ),
//     // );

//     // _payments.add(
//     //   PaymentModel(
//     //     id: UniqueKey().toString(),
//     //     loanId: 'shay_loan_one',
//     //     clientId: 'shay',
//     //     expectedInterestAmount: 75000,
//     //     expectedPrincipalAmount: 0,
//     //     interestRate: 3,
//     //     actualPayDate: null,
//     //     expectedPayDate: DateTime(2023, 12, 01),
//     //   ),
//     // );
//   }

//   // PaymentModel getPaymentById(String id) {
//   //   return _payments.where((payment) => payment.id == id).toList().first;
//   // }

//   // List<PaymentModel> getPaymentsByLoanId(String loanId) {
//   //   return _payments.where((payment) => payment.loanId == loanId).toList();
//   // }

//   // void updatePayment(PaymentModel payment) {
//   //   var index = _payments.indexWhere((element) => element.id == payment.id);
//   //   _payments[index] = payment;
//   //   notifyListeners();
//   // }

//   // double getTotalAmountOfInterestPayments(String paymentId) {
//   //   var receipts = receiptProvider.getReceiptsByPaymentId(paymentId).toList();

//   //   return receipts.fold(
//   //       0, (previousValue, element) => previousValue + element.interestPayment);
//   // }

//   // double getTotalAmountOfPrincipalPayments(String paymentId) {
//   //   var receipts = receiptProvider.getReceiptsByPaymentId(paymentId).toList();

//   //   return receipts.fold(0,
//   //       (previousValue, element) => previousValue + element.principalPayment);
//   // }

//   // double getRemainingInterestAmountToBePaid(String paymentId) {
//   //   var payment = getPaymentById(paymentId);
//   //   var receipts = receiptProvider.getReceiptsByPaymentId(paymentId).toList();

//   //   return payment.expectedInterestAmount -
//   //       receipts.fold(
//   //           0, (previousValue, element) => previousValue + element.interestPayment);
//   // }

//   // double getRemainingPrincipalAmountToBePaid(String paymentId) {
//   //   var payment = getPaymentById(paymentId);
//   //   var receipts = receiptProvider.getReceiptsByPaymentId(paymentId).toList();

//   //   return payment.expectedPrincipalAmount -
//   //       receipts.fold(0,
//   //           (previousValue, element) => previousValue + element.principalPayment);
//   // }

//   // double getRemainingTotalAmountToBePaid(String paymentId) {
//   //   return getRemainingInterestAmountToBePaid(paymentId) +
//   //       getRemainingPrincipalAmountToBePaid(paymentId);
//   // }
// }
