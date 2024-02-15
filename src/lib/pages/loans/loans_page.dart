import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/loans/empty_loan_list_component.dart';
import 'package:pokinia_lending_manager/components/loans/loan_list_card_component.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/models/loan_model.dart';
import 'package:pokinia_lending_manager/pages/loans/new_loan_page.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:provider/provider.dart';

class LoansPage extends StatelessWidget {
  LoansPage({super.key});

  var cachedClients = List<ClientModel>.empty(growable: true);

  @override
  Widget build(BuildContext context) {

    return Consumer2<ClientService, LoanService>(builder: 
      (context, clientService, loanService, _) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const HeaderTwoText(text: "Loans"),
                scrolledUnderElevation: 0,
                floating: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      showMaterialModalBottomSheet(
                        enableDrag: false,
                        isDismissible: false,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                        ),
                        context: context,
                        builder: (context) => const NewLoanPage(),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 28.0,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final LoanModel loan = loanService.loans[index];
                    final ClientModel client = clientService.getClientById(loan.clientId);

                    return LoanListCard(client: client, loan: loan);
                  },
                  childCount: loanService.loans.length,
                ),
              )
            ],
          ),
        );
      },
    );

  }
}
