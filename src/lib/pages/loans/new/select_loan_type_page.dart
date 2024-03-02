import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/enums/loan_types.dart';
import 'package:pokinia_lending_manager/pages/loans/new/new_zero_interest_loan_page.dart';
import 'package:pokinia_lending_manager/services/logger.dart';

class SelectLoanTypePage extends StatelessWidget {
  final Logger _logger = getLogger('NewLoanPage');

  SelectLoanTypePage({super.key});

  void _onLoanSelected(BuildContext context, LoanTypes loanType) {
    _logger.i('Loan type selected: $loanType');

    if (loanType == LoanTypes.openEndedLoan) {
      // Open-ended loan
    } else if (loanType == LoanTypes.termLoan) {
      // Term loan
    } else if (loanType == LoanTypes.ballonLoan) {
      // Ballon loan
    } else if (loanType == LoanTypes.zeroInterestLoan) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  const NewZerointerestLoanPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose loan type'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _getLoanTypeWidget(
              context,
              'Open-ended loan',
              'This loan does not require an end-date. \n\nLoan statements will be generated according to parameters with expected pay dates with an expected principal and interest amount to be paid on those dates.',
              LoanTypes.openEndedLoan),
          _getLoanTypeWidget(
              context,
              'Term loan',
              'This loan requires an end-date. \n\nLoan statements will be generated with expected principal and interest amount to be paid as well as expected pay dates.',
              LoanTypes.termLoan),
          _getLoanTypeWidget(
              context,
              'Ballon loan',
              'Generates one loan statement with a principal amount and interest amount as well as an expected pay date.',
              LoanTypes.ballonLoan),
          _getLoanTypeWidget(
              context,
              'Zero-interest loan',
              'Generates one loan statement with a principal amount but no interest amount with an optional expected pay date.',
              LoanTypes.zeroInterestLoan),
        ],
      )),
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
