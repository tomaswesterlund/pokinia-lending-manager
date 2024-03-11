import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/enums/loan_types.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/ui/components/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/ui/components/boxes/deleted_alert_box.dart';
import 'package:pokinia_lending_manager/ui/components/buttons/fabs.dart';
import 'package:pokinia_lending_manager/ui/components/clients/client_app_bar.dart';
import 'package:pokinia_lending_manager/ui/components/clients/client_contact.dart';
import 'package:pokinia_lending_manager/ui/components/clients/list_cards/client_open_ended_loan_list_card.dart';
import 'package:pokinia_lending_manager/ui/components/clients/list_cards/client_zero_interest_loan_list_card.dart';
import 'package:pokinia_lending_manager/ui/components/status_boxes/payment_status/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/ui/components/status_boxes/payment_status/wide_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/ui/components/texts/amounts/big_amount_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/headers/header_five_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/ui/pages/loans/loan_page.dart';
import 'package:pokinia_lending_manager/ui/pages/loans/selector/select_loan_type_page.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ClientPage extends StatefulWidget {
  final String clientId;

  const ClientPage({super.key, required this.clientId});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final Logger _logger = getLogger('ClientPage');

  @override
  Widget build(BuildContext context) {
    return Consumer2<ClientProvider, LoanProvider>(
      builder: (context, clientProvider, loanProvider, child) {
        var client = clientProvider.getById(widget.clientId);
        var loans = loanProvider.getByClientId(widget.clientId);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              ClientAppBar(
                  clientId: widget.clientId,
                  title: 'Client',
                  isDeleted: client.deleted),
              MultiSliver(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            client.deleted
                                ? DeletedAlertBox(
                                    title: 'This client has been deleted!',
                                    deleteDate: client.deleteDate,
                                    deleteReason: client.deleteReason)
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyAvatarComponent(
                              name: client.name,
                              avatarImagePath: client.avatarImagePath),
                          const SizedBox(width: 16.0),
                          HeaderThreeText(text: client.name),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const ParagraphTwoText(text: "Status"),
                                const Spacer(),
                                WidePaymentStatusBoxComponent(
                                    paymentStatus: client.paymentStatus)
                              ],
                            ),
                          ],
                        ),
                      ),
                      ClientContact(client: client)
                    ],
                  ),
                  const Center(child: HeaderThreeText(text: "Loans")),
                  _getLoansWidget(context, loans),
                  const SizedBox(height: 128.0)
                ],
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: getDefaultFab(
            onPressed: () => showMaterialModalBottomSheet(
              enableDrag: true,
              isDismissible: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              context: context,
              builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SelectLoanTypePage()),
            ),
          ),
        );
      },
    );
  }

  Widget _getLoansWidget(BuildContext context, List<Loan> loans) {
    try {
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
        // return const Text("Test");
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              var loan = loans[index];
              return _getLoanListCard(context, loan);
            },
            childCount: loans.length,
          ),
        );
      }
    } catch (e) {
      _logger.e(e);
      return const Center(
        child: ParagraphTwoText(
            text: "An error occurred while loading the loans."),
      );
    }
  }
}

Widget _getLoanListCard(BuildContext context, Loan loan) {
  if (loan.type == LoanTypes.openEndedLoan) {
    return ClientOpenEndedLoanListCard(loanId: loan.id);
  } else if (loan.type == LoanTypes.zeroInterestLoan) {
    return ClientZeroInterestLoanListCard(loanId: loan.id);
  } else {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoanPage(loanId: loan.id))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                    const BigAmountText(text: "-1"),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
