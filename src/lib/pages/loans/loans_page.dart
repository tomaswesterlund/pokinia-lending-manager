import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/fabs.dart';
import 'package:pokinia_lending_manager/components/loans/empty_loan_list_component.dart';
import 'package:pokinia_lending_manager/components/loans/loan_list_card_component.dart';
import 'package:pokinia_lending_manager/components/loans/open_ended/open_ended_loan_list_card_component.dart';
import 'package:pokinia_lending_manager/components/loans/zero_interest/zero_interest_loan_list_card_component.dart';
import 'package:pokinia_lending_manager/components/my_drawer.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/enums/loan_types.dart';
import 'package:pokinia_lending_manager/models/data/client.dart';
import 'package:pokinia_lending_manager/models/data/loan.dart';
import 'package:pokinia_lending_manager/pages/loans/selector/select_loan_type_page.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/services/loans/loan_service.dart';
import 'package:pokinia_lending_manager/services/loans/open_ended_loan_service.dart';
import 'package:pokinia_lending_manager/services/loans/zero_interest_loan_service.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:provider/provider.dart';

class LoansPage extends StatelessWidget {
  const LoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = getLogger('LoansPage');
    logger.i('Building LoansPage');

    return Consumer4<ClientService, LoanService, OpenEndedLoanService,
        ZeroInterestLoanService>(
      builder: (context, clientService, loanService, openEndedLoanService,
          zeroInterestLoanService, _) {
        return Scaffold(
            body: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: HeaderTwoText(text: "Loans"),
                  scrolledUnderElevation: 0,
                  floating: true,
                ),
                loanService.loans.isEmpty
                    ? const SliverFillRemaining(
                        child: Center(child: EmptyLoanList()),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final Loan loan = loanService.loans[index];
                            final Client client =
                                clientService.getClientById(loan.clientId);

                            if (loan.type == LoanTypes.zeroInterestLoan) {
                              var zeroInterestLoan =
                                  zeroInterestLoanService.getLoanByLoanId(loan.id);

                              return ZeroInterestLoanListCard(
                                  client: client,
                                  loan: loan,
                                  zeroInterestLoan: zeroInterestLoan);
                            } else if (loan.type == LoanTypes.openEndedLoan) {
                              var openEndedLoan = openEndedLoanService.getLoanByLoanId(loan.id);
                              
                              return OpenEndedLoanListCard(
                                  client: client,
                                  loan: loan,
                                  openEndedLoan: openEndedLoan);
                            } else {
                              return LoanListCard(client: client, loan: loan);
                            }
                          },
                          childCount: loanService.loans.length,
                        ),
                      )
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: getDefaultFab(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectLoanTypePage()))),
            endDrawer: Drawer(
              child: MyDrawer(),
            ));
      },
    );
  }
}
