// import 'package:flutter/material.dart';
// import 'package:pokinia_lending_manager/enums/loan_payment_status.dart';
// import 'package:pokinia_lending_manager/enums/payment_status_enum.dart';
// import 'package:pokinia_lending_manager/models/loan_model.dart';
// import 'package:pokinia_lending_manager/providers/payment_provider.dart';
// import 'package:pokinia_lending_manager/services/loan_service.dart';

// class LoanProvider extends ChangeNotifier {
//   final DatabaseService databaseService;
//   final PaymentProvider paymentProvider;


//   LoanProvider({required this.paymentProvider, required this.databaseService}) {
//     // Client one
//     // _loans.add(LoanModel(
//     //     id: 'habibi_loan_one',
//     //     clientId: 'habibi',
//     //     initialAmountLent: 500000,
//     //     initialInterestRate: 5.0));
//     // _loans.add(LoanModel(
//     //     id: 'habibi_loan_two',
//     //     clientId: 'habibi',
//     //     initialAmountLent: 500000,
//     //     initialInterestRate: 5.0));
//     // _loans.add(LoanModel(
//     //     id: 'habibi_loan_three',
//     //     clientId: 'habibi',
//     //     initialAmountLent: 500000,
//     //     initialInterestRate: 5.0));

//     // // Shay
//     // _loans.add(LoanModel(
//     //     id: 'shay_loan_one',
//     //     clientId: 'shay',
//     //     initialAmountLent: 3000000,
//     //     initialInterestRate: 5));

//     // _loans.add(LoanModel(
//     //     id: 'client_three_loan_one',
//     //     clientId: 'client_three',
//     //     initialAmountLent: 999999999999999,
//     //     initialInterestRate: 5));
//   }

//   Stream<List<LoanModel>> get loanStream => databaseService.getLoansStream();

  

//   void addLoan(LoanModel loan) {
//     databaseService.addLoan(loan);
//     notifyListeners();
//   }

//   // void removeLoan(LoanModel loan) {
//   //   _loans.remove(loan);
//   //   notifyListeners();
//   // }

//   Stream<LoanModel> getLoanByIdStream(String id) {
//     return databaseService.getLoanByIdStream(id);
//   }

//   Stream<List<LoanModel>> getLoansByClientIdStream(String cliendId) {
//     return databaseService.getLoansByClientIdStream(cliendId);
//   }

//   LoanPaymentStatus getLoanPaymentStatus(String loanId) {
//     var payments = paymentProvider.getPaymentsByLoanId(loanId);

//     if (payments.isEmpty) {
//       return LoanPaymentStatus.empty;
//     } else {
//       if (payments
//           .any((payment) => payment.paymentStatus == PaymentStatus.overdue)) {
//         return LoanPaymentStatus.overdue;
//       } else {
//         return LoanPaymentStatus.prompt;
//       }
//     }
//   }



//   double getTotalAmountOfPrincipalPayments(String loanId) {
//     var payments = paymentProvider.getPaymentsByLoanId(loanId);

//     double sum = 0.0;

//     for (var payment in payments) {
//       sum += paymentProvider.getTotalAmountOfPrincipalPayments(payment.id);
//     }

//     return sum;
//   }

//   double getTotalAmountPaidInInterests(String loanId) {
//     var payments = paymentProvider.getPaymentsByLoanId(loanId);

//     double sum = 0.0;

//     for (var payment in payments) {
//       sum += paymentProvider.getTotalAmountOfInterestPayments(payment.id);
//     }

//     return sum;
//   }
// }
