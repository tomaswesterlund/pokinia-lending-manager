import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/headers/header_two_text.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HeaderTwoText(text: "Payments"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: const Scaffold()
    );
    // return Scaffold(
    //   body: Consumer<PaymentsPageProvider>(
    //     builder: (context, provider, _) {
    //       return CustomScrollView(
    //         slivers: [
    //           const SliverAppBar(
    //             title: HeaderTwoText(text: "Payments"),
    //             scrolledUnderElevation: 0,
    //             floating: true,
    //           ),
    //           loanStatementService.getOverdueLoanStatements().isEmpty &&
    //                   paymentService.getRecentlyPaidPayments().isEmpty
    //               ? const SliverFillRemaining(
    //                   child: Center(child: Text("No payments")),
    //                 )
    //               : MultiSliver(
    //                   children: [
    //                     _getTitleWidget("Overdue payments"),
    //                     _getOverduePaymentsWidget(clientService, loanStatementService),
    //                     _getTitleWidget("Recent payments"),
    //                     _getRecentlyPaidPaymentsWidget(clientService, loanStatementService, paymentService)
    //                   ],
    //                 )
    //         ],
    //       );
    //     },
    //   ),
    //   endDrawer:  const Drawer(
    //     child: MyDrawer(),
    //   )
    // );
  }

  Widget _getTitleWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: HeaderFourText(
        text: text,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  // SliverList _getOverduePaymentsWidget(
  //     ClientProvider clientService, LoanStatementProvider loanStatementService) {
  //   return SliverList(
  //     delegate: SliverChildBuilderDelegate(
  //       (context, index) {
  //         var loneStatement =
  //             loanStatementService.getOverdueLoanStatements()[index];
  //         var client = clientService.getById(loneStatement.clientId);

  //         return PaymentListCard(client: client, loanStatement: loneStatement);
  //       },
  //       childCount: loanStatementService.getOverdueLoanStatements().length,
  //     ),
  //   );
  // }

  // SliverList _getRecentlyPaidPaymentsWidget(
  //     ClientProvider clientService,
  //     LoanStatementProvider loanStatementService,
  //     PaymentProvider paymentService) {
  //   return SliverList(
  //     delegate: SliverChildBuilderDelegate(
  //       (context, index) {
  //         // var payment = paymentService.getRecentlyPaidPayments()[index];
  //         // var loneStatement = loanStatementService
  //         //     .getLoanStatementById(payment.loanStatementId!);
  //         // var client = clientService.getClientById(payment.clientId);

  //         // return PaymentListCard(client: client, loanStatement: loneStatement);

  //         return const Text("Not implemented!");
  //       },
  //       childCount: paymentService.getRecentlyPaidPayments().length,
  //     ),
  //   );
  // }
}
