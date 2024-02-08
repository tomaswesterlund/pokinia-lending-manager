import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/loans/empty_loan_list_component.dart';
import 'package:pokinia_lending_manager/components/loans/loan_list_card_component.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:provider/provider.dart';

class LoansPage extends StatelessWidget {
  const LoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    var clientService = Provider.of<ClientService>(context, listen: false);
    var loanService = Provider.of<LoanService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const HeaderTwoText(text: "Loans"),
      ),
      body: StreamBuilder<List>(
        stream: loanService.getLoansStream(),
        builder: (context, loanSnapshot) {
          if (loanSnapshot.hasData) {
            if (loanSnapshot.data!.isNotEmpty) {
              return ListView.builder(
                  itemCount: loanSnapshot.data!.length,
                  itemBuilder: (context, index) {
                    var loan = loanSnapshot.data![index];

                    return StreamBuilder(
                      stream: clientService.getClientByIdStream(loan.clientId),
                      builder: (context, clientSnapshot) {
                        if (clientSnapshot.hasData) {
                          var client = clientSnapshot.data!;
                          return LoanListCard(client: client, loan: loan);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    );
                  });
            } else {
              return const EmptyLoanList();
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
