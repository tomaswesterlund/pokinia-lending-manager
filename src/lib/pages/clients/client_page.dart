import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: Text(client.name),
        ),
        body: Consumer2<ClientService, LoanService>(
          builder: (context, clientService, loanService, child) {
            return Column(
              children: [
                _getAvatarWidget(client),
                const SizedBox(height: 16.0),

                // Name
                HeaderThreeText(text: client.name),
                const SizedBox(height: 16.0),

                // Status
                WideClientStatusBoxComponent(
                    paymentStatus: client.paymentStatus),

                const SizedBox(height: 16.0),

                _getContactButtonsWidget(),
                _getContactInformationWidget(),

                //Edit button
                const Text("Edit"),

                // Separator
                const Divider(color: Colors.grey, thickness: 2),

                _getLoansWidget(loanService.getLoansByClientId(client.id)),

                // New loan
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: MyFab(
                      subTitle: "New loan",
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewLoanPage(selectedClient: client)))),
                ),
              ],
            );
          },
        ));
  }

  Widget _getAvatarWidget(ClientModel client) {
    if (client.avatarImagePath != null) {
      return AdvancedAvatar(
        size: 96,
        image: NetworkImage(client.avatarImagePath!),
        foregroundDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF008080),
            width: 2.0,
          ),
        ),
      );
    } else {
      return AdvancedAvatar(
        name: client.name,
        size: 96.0,
        autoTextSize: true,
        foregroundDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF008080),
            width: 2.0,
          ),
        ),
      );
    }
  }

  Widget _getContactButtonsWidget() {
    return Row(
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
    );
  }

  Widget _getContactInformationWidget() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.phone),
              const SizedBox(width: 8.0),
              ParagraphOneText(
                  text: client.phoneNumber, fontWeight: FontWeight.bold)
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 8.0),
              ParagraphOneText(
                  text: client.address ?? "No address",
                  fontWeight: FontWeight.bold),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getLoansWidget(List<LoanModel> loans) {
    return Expanded(
      child: ListView.builder(
        itemCount: loans.length,
        itemBuilder: (context, index) {
          var loan = loans[index];

          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LoanPage(clientId: client.id, loanId: loan.id))),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CompactLoanStatusBoxComponent(
                              paymentStatus: loan.paymentStatus),
                          const SizedBox(width: 20),
                          BigAmountText(
                              text: loan.remainingPrincipalAmount
                                  .toFormattedCurrency()),
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
    );
  }
}
