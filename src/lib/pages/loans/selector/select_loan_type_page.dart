import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/enums/loan_types.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/pages/loans/selector/select_payment_period_page.dart';
import 'package:pokinia_lending_manager/pages/loans/zero_interest_loans/new_zero_interest_loan_page.dart';

class SelectLoanTypePage extends StatelessWidget {
  final Logger _logger = getLogger('NewLoanPage');

  SelectLoanTypePage({super.key});

  void _onLoanSelected(BuildContext context, LoanTypes loanType) {
    _logger.i('Loan type selected: $loanType');

    if (loanType == LoanTypes.openEndedLoan) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SelectPaymentPeriodPage()));
    } else if (loanType == LoanTypes.termLoan) {
      // Term loan
    } else if (loanType == LoanTypes.ballonLoan) {
      // Ballon loan
    } else if (loanType == LoanTypes.zeroInterestLoan) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const NewZerointerestLoanPage()));
    }
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: const HeaderThreeText(text: 'Select loan type'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getLoanTypeWidget(
                context,
                'Open-ended loan',
                'A loan with a principal amount and on-going (automatically generated) loan statements with an expected interest amount to be paid on the expected pay dates. This loan does not require an end-date.',
                LoanTypes.openEndedLoan),
            _getLoanTypeWidget(
                context,
                'Zero-interest loan',
                'Generates a loan with a principal amount but no interest amount with an optional expected end pay date.',
                LoanTypes.zeroInterestLoan),
          ],
        ),
      ),
    );

  }

  Widget _getLoanTypeWidget(BuildContext context, String title,
      String description, LoanTypes loanType) {
    return GestureDetector(
      onTap: () => _onLoanSelected(context, loanType),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF8F8F8),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]!,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              // Added Flexible here to allow the column to shrink
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderThreeText(text: title),
                  ParagraphTwoText(text: description),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
