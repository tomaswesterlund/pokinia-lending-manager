import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_five_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraphs/paragraph_two_text.dart';

class EmptyLoanList extends StatelessWidget {
  const EmptyLoanList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 100),
              Image.asset('assets/images/empty_list_loans.png'),
              const SizedBox(height: 25),
              const HeaderFiveText(text: "No active loans were found."),
              const ParagraphTwoText(text: "Would you like to create a new loan?", color: Color(0xFF1D2424)),
            ],
          ),
        ],
      ),
    );
  }
}
