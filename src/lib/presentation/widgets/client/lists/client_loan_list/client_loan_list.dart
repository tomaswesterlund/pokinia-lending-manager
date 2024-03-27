import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/headers/header_five_text.dart';
import 'package:pokinia_lending_manager/core/enums/loan_types.dart';
import 'package:pokinia_lending_manager/domain/entities/loan_entity.dart';
import 'package:pokinia_lending_manager/presentation/widgets/client/lists/client_loan_list/client_open_ended_loan_list_card.dart';
import 'package:pokinia_lending_manager/presentation/widgets/client/lists/client_loan_list/client_zero_interest_loan_list_card.dart';
import 'package:pokinia_lending_manager/view_models/widgets/client/loan_list/client_loan_list_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/shared/unexpected_error.dart';
import 'package:provider/provider.dart';

class ClientLoanList extends StatelessWidget {
  final String clientId;
  const ClientLoanList({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientLoanListViewModel>(
      builder: (context, vm, _) {
        return vm.getLoansForClient(clientId).fold(
          (error) {
            return const UnexpectedError();
          },
          (loans) {
            return loans.isEmpty
                ? _getNoLoansWidget()
                : _getLoanListWidget(loans);
          },
        );
      },
    );
  }

  Widget _getLoanListWidget(List<LoanEntity> loans) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: loans.length,
        (context, index) {
          var loan = loans[index];
          if (loan.type == LoanTypes.openEndedLoan) {
            return ClientOpenEndedLoanListCard(loan: loan);
          } else if (loan.type == LoanTypes.zeroInterestLoan) {
            return ClientZeroInterestLoanListCard(loanId: loan.id);
          } else {
            return const Text("[ClientLoanList]: Loan type not implemented yet!");
          }
        },
      ),
    );
  }

  Widget _getNoLoansWidget() {
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
  }
}
