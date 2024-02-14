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
    var clientService = Provider.of<ClientService>(context, listen: false);
    var loanService = Provider.of<LoanService>(context, listen: false);

    return Scaffold(
      body: StreamBuilder(
        stream: clientService.getClientsStream(),
        builder: (context, clientsSnapshot) {
          if (clientsSnapshot.hasData) {
            if (clientsSnapshot.data!.isNotEmpty) {
              List<ClientModel> clients = clientsSnapshot.data!;
              return StreamBuilder(
                stream: loanService.getLoansStream(),
                builder: (context, loansSnapshot) {
                  if (loansSnapshot.hasData) {
                    if (loansSnapshot.data!.isNotEmpty) {
                      List<LoanModel> loans = loansSnapshot.data!;
                      return CustomScrollView(
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
                                final ClientModel client = clients.firstWhere(
                                    (client) =>
                                        client.id == loans[index].clientId);
                                final LoanModel loan = loans[index];

                                return LoanListCard(client: client, loan: loan);
                              },
                              childCount: loans.length,
                            ),
                          )
                        ],
                      );
                    } else if (loansSnapshot.data!.isEmpty) {
                      return const EmptyLoanList();
                    } else {
                      // Error (?)
                      return const Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            } else if (clientsSnapshot.data!.isEmpty) {
              return const EmptyLoanList();
            } else {
              // Error (?)
              return const Center(child: CircularProgressIndicator());
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },

        // child:
        // StreamBuilder(
        //   stream: loanService.getLoansStream(),
        //   builder: (context, loansSnapshot) {
        //     if (loansSnapshot.hasData) {
        //       if (loansSnapshot.data!.isNotEmpty) {
        //         List<LoanModel> loans = loansSnapshot.data!;
        //         return CustomScrollView(
        //           slivers: [
        //             SliverAppBar(
        //               title: const HeaderTwoText(text: "Loans"),
        //               scrolledUnderElevation: 0,
        //               floating: true,
        //               actions: [
        //                 IconButton(
        //                   onPressed: () {
        //                     showMaterialModalBottomSheet(
        //                       enableDrag: false,
        //                       isDismissible: false,
        //                       shape: const RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.only(
        //                           topLeft: Radius.circular(15.0),
        //                           topRight: Radius.circular(15.0),
        //                         ),
        //                       ),
        //                       context: context,
        //                       builder: (context) => const NewClientPage(),
        //                     );
        //                   },
        //                   icon: const Icon(
        //                     Icons.add,
        //                     size: 28.0,
        //                     color: Colors.black,
        //                   ),
        //                 )
        //               ],
        //             ),
        //             SliverList(
        //               delegate: SliverChildBuilderDelegate(
        //                 (context, index) {
        //                   final ClientModel client = _getClientById(
        //                       context, loans[index].clientId).then((value) {
        //                         return const Text("Test");
        //                       });
        //                   final LoanModel loan = loans[index];

        //                   return LoanListCard(client: client, loan: loan);
        //                 },
        //                 childCount: loans.length,
        //               ),
        //             )
        //           ],
        //         );
        //       } else if (loansSnapshot.data!.isEmpty) {
        //         return const EmptyLoanList();
        //       } else {
        //         // Error (?)
        //         return const Center(child: CircularProgressIndicator());
        //       }
        //     } else {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //   },
        // ),
      ),
    );
  }
}
