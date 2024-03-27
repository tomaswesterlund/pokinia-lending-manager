import 'package:flutter/widgets.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/core/util/date_extensions.dart';
import 'package:pokinia_lending_manager/view_models/widgets/loan/expected_pay_date_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/shared/unexpected_error.dart';
import 'package:provider/provider.dart';

class ExpectedPayDate extends StatelessWidget {
  final String loanId;
  const ExpectedPayDate({super.key, required this.loanId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpectedPayDateViewModel>(
      builder: (context, vm, _) {
        return vm.getExpectedPayDate(loanId).fold(
          (error) => const UnexpectedError(),
          (expectedPayDate) {
            return Row(
              children: [
                const ParagraphTwoText(
                    text: "End date: ", color: Color(0xFF9EA6A7)),
                ParagraphTwoText(
                    text: expectedPayDate != null
                        ? expectedPayDate.toFormattedDate()
                        : "None",
                    color: const Color(0xFF1C2829)),
              ],
            );
          },
        );
      },
    );
  }
}
