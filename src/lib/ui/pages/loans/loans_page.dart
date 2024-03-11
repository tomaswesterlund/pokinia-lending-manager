import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/enums/loan_types.dart';
import 'package:pokinia_lending_manager/providers/loans/loan_provider.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/ui/components/buttons/fabs.dart';
import 'package:pokinia_lending_manager/ui/components/loans/empty_loan_list_component.dart';
import 'package:pokinia_lending_manager/ui/components/loans/open_ended_loans/lists/open_ended_loan_list_card.dart';
import 'package:pokinia_lending_manager/ui/components/loans/zero_interest/zero_interest_loan_list_card_component.dart';
import 'package:pokinia_lending_manager/ui/components/my_drawer.dart';
import 'package:pokinia_lending_manager/ui/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/ui/pages/loans/selector/select_loan_type_page.dart';
import 'package:provider/provider.dart';

class LoansPage extends StatelessWidget {
  const LoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = getLogger('LoansPage');
    logger.i('Building LoansPage');

    return Consumer<LoanProvider>(
      builder: (context, provider, _) {
        var loans = provider.loans;

        return Scaffold(
            body: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: HeaderTwoText(text: "Loans"),
                  automaticallyImplyLeading: false,
                  scrolledUnderElevation: 0,
                  floating: true,
                ),
                loans.isEmpty
                    ? const SliverFillRemaining(
                        child: Center(child: EmptyLoanList()),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            var loan = loans[index];

                            if (loan.type == LoanTypes.zeroInterestLoan) {
                              return ZeroInterestLoanListCard(loanId: loan.id);
                            } else if (loan.type == LoanTypes.openEndedLoan) {
                              return OpenEndedLoanListCard(loanId: loan.id);
                            } else {
                              return const Placeholder();
                              // return LoanListCard(client: client, loan: loan);
                            }
                          },
                          childCount: loans.length,
                        ),
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
            endDrawer: Drawer(
              child: MyDrawer(),
            ));
      },
    );
  }
}
