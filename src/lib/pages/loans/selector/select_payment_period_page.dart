import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/models/loans/new_open_ended_loan_parameters.dart';
import 'package:pokinia_lending_manager/pages/loans/open_ended/new_open_ended_loan_page.dart';
import 'package:pokinia_lending_manager/services/logger.dart';

class SelectPaymentPeriodPage extends StatelessWidget {
  final Logger _logger = getLogger('SelectPaymentPeriodPage');

  SelectPaymentPeriodPage({super.key});

  void _onLoanSelected(BuildContext context, String paymentPeriod) {
    _logger.i('Payment period selected: $paymentPeriod');
    var params = NewOpenEndedLoanParameters();
    params.paymentPeriod = paymentPeriod;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewOpenEndedLoanPage(params: params)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose payment period'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _getPaymentPeriodWidget(context, 'Monthly', '-', 'monthly'),
          _getPaymentPeriodWidget(context, 'Weekly', '-', 'weekly'),
          _getPaymentPeriodWidget(context, 'Custom', '-', 'custom'),
        ],
      )),
    );
  }

  Widget _getPaymentPeriodWidget(BuildContext context, String title,
      String description, String paymentPeriod) {
    return GestureDetector(
      onTap: () => _onLoanSelected(context, paymentPeriod),
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
