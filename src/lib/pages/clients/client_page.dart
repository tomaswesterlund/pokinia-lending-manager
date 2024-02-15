import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/compact_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/wide_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_five_text.dart';
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
                MyAvatarComponent(client: client, size: 96.0, strokeWidth: 2.0),
                const SizedBox(height: 16.0),

                // Name
                HeaderThreeText(text: client.name),
                const SizedBox(height: 16.0),

                // Status
                WidePaymentStatusBoxComponent(
                    paymentStatus: client.paymentStatus),

                const SizedBox(height: 16.0),

                _getContactButtonsWidget(),
                _getContactInformationWidget(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Container(),
                    const Center(
                      child: HeaderThreeText(text: "Loans"),
                    ),
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
                          builder: (context) => NewLoanPage(
                            selectedClient: client,
                          ),
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
                _getLoansWidget(loanService.getLoansByClientId(client.id)),
              ],
            );
          },
        ));
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
    if (loans.isEmpty) {
      return Column(
        children: [
          const SizedBox(height: 25),
          Image.asset(
            'assets/images/empty_list_loans.png',
            width: 256,
          ),
          const SizedBox(height: 25),
          const HeaderFiveText(text: "No active loans were found."),
        ],
      );
    } else {
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
                            SquaredPaymentStatusBoxComponent(
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
}
