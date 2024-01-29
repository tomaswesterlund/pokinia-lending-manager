import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/texts/header_five_text.dart';
import 'package:pokinia_lending_manager/components/texts/my_sub_heading_text.dart';

class LoansPage extends StatelessWidget {
  const LoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loans'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset('assets/images/empty_list_loans.png'),
            
            const SizedBox(height: 25),
            
            const HeaderFiveText(text: "No active loans were found."),
            const MySubHeadingText(text: "Would you like to create a new loan?"),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
