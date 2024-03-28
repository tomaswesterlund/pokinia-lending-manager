import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/loan_types.dart';
import 'package:pokinia_lending_manager/presentation/pages/loans/selector/select_loan_type_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan/empty_loan_list_component.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan/open_ended/open_ended_loan_list_card.dart';
import 'package:pokinia_lending_manager/presentation/widgets/loan/zero_interest/zero_interest_loan_list_card.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/buttons/fabs.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/unexpected_error.dart';
import 'package:pokinia_lending_manager/view_models/pages/loan/loans_page_view_model.dart';
import 'package:provider/provider.dart';

class LoansPage extends StatelessWidget {
  const LoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoansPageViewModel>(
      builder: (context, vm, _) {
        // TODO: Implement "Show Deleted"
        return vm.getAllLoans().fold(
              (error) => const UnexpectedError(),
              (loans) => Scaffold(
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
                                  return ZeroInterestLoanListCard(
                                      loanId: loan.id);
                                } else if (loan.type ==
                                    LoanTypes.openEndedLoan) {
                                  return OpenEndedLoanListCard(loanId: loan.id);
                                }

                                return const Placeholder();
                              },
                              childCount: loans.length,
                            ),
                          )
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: getDefaultFab(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectLoanTypePage()));
                  },
                ),
              ),
            );
      },
    );
  }
}
