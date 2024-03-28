import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/texts/paragraphs/paragraph_two_text.dart';

class ErrorLoanListCard extends StatelessWidget {
  const ErrorLoanListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      // height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF8F8F8),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          SizedBox(width: 15),
          ParagraphTwoText(text:  "An error occurred!")
        ],
      ),
    );
  }
}
