import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_fab.dart';
import 'package:pokinia_lending_manager/components/status_boxes/client_payment_status/wide_client_status_box_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/loan_payment_status/compact_loan_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/models/loan_model.dart';
import 'package:pokinia_lending_manager/pages/loans/loan_page.dart';
import 'package:pokinia_lending_manager/pages/loans/new_loan_page.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loan_service.dart';
import 'package:pokinia_lending_manager/util/double_extensions.dart';
import 'package:provider/provider.dart';

class ClientPage extends StatelessWidget {
  final ClientModel client;

  const ClientPage({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    var clientService = Provider.of<ClientService>(context, listen: false);
    var loanService = Provider.of<LoanService>(context, listen: false);

    // CLIENT - StreamBuilder
    return Scaffold(
      appBar: AppBar(
        title: Text(client.name),
      ),
      body: StreamBuilder<ClientModel>(
        stream: clientService.getClientByIdStream(client.id),
        builder: (context, clientSnapshot) {
          if (clientSnapshot.hasError) {
            debugPrint(clientSnapshot.error.toString());
            return const Center(child: Text('Error loading clients'));
          } else if (!clientSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            var client = clientSnapshot.data!;

            // LOAN - StreamBuilder
            return StreamBuilder<List<LoanModel>>(
              stream: loanService.getLoansByClientIdStream(client.id),
              builder: (context, loansSnapshot) {
                if (loansSnapshot.hasError) {
                  debugPrint(loansSnapshot.error.toString());
                  return const Center(child: Text('Error loading loans'));
                } else if (!loansSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  var loans = loansSnapshot.data!;

                  // SCAFFOLD
                  return Column(
                    children: [
                      // Image
                      CircularProfileAvatar(
                        '',
                        borderColor: const Color(0xFF008080),
                        borderWidth: 5,
                        elevation: 2,
                        radius: 50,
                        child: Image.asset("assets/images/dummy_avatar_2.webp"),
                      ),

                      const SizedBox(height: 16.0),

                      // Name
                      HeaderThreeText(text: client.name),

                      const SizedBox(height: 16.0),

                      // Status
                      WideClientStatusBoxComponent(
                          paymentStatus: client.paymentStatus),

                      const SizedBox(height: 16.0),
                      //Contact buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Call button
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2F2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.call),
                              color: const Color(0xFF008080),
                              onPressed: () {},
                            ),
                          ),

                          const SizedBox(width: 16),

                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2EEE3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.message),
                              color: const Color(0xFFEAB308),
                              onPressed: () {},
                            ),
                          ),

                          const SizedBox(width: 16),

                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2E3E3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.map),
                              color: const Color(0xFFEB5857),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),

                      // Phone number
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.phone),
                                const SizedBox(width: 8.0),
                                ParagraphOneText(text: client.phoneNumber, fontWeight: FontWeight.bold)
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            // Address
                             Row(
                              children: [
                                const Icon(Icons.location_on),
                                const SizedBox(width: 8.0),
                                ParagraphOneText(
                                    text: "Some direction ...", fontWeight: FontWeight.bold),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //Edit button
                      const Text("Edit"),

                      // Separator
                      const Divider(color: Colors.grey, thickness: 2),

                      // Loans
                      Expanded(
                        child: ListView.builder(
                          itemCount: loans.length,
                          itemBuilder: (context, index) {
                            var loan = loans[index];

                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoanPage(
                                          clientId: client.id,
                                          loanId: loan.id))),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFFF8F8F8),
                                    border: const Border(
                                      bottom: BorderSide(
                                        color: Color(0xFFD2DEE0),
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CompactLoanStatusBoxComponent(
                                                paymentStatus:
                                                    loan.paymentStatus),
                                            const SizedBox(width: 20),
                                            BigAmountText(
                                                text: loan
                                                    .remainingPrincipalAmount.toFormattedCurrency()),
                                          ],
                                        ),
                                        const Icon(Icons.arrow_forward_ios),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          shrinkWrap: true,
                        ),
                      ),

                      // New loan
                      MyFab(
                          subTitle: "New loan",
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewLoanPage(clientId: client.id)))),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
