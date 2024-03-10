import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';

class DeletedAlert extends StatelessWidget {
  final String title;
  final DateTime? deleteDate;
  final String? deleteReason;

  const DeletedAlert(
      {super.key, required this.title, this.deleteDate, this.deleteReason});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20), // Adjust the margin as needed
      padding: const EdgeInsets.all(20), // Adjust the padding as needed
      decoration: BoxDecoration(
        color:
            const Color(0xFFF2E3E3), // This is a lighter red for the fill color
        border: Border.all(
          color: const Color(0xFFEB5857), // Red border color
          width: 2, // Border width
        ),
        borderRadius:
            BorderRadius.circular(10), // Adjust the corner radius as needed
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(  
            children: [
              const Icon(Icons.delete, color: Color(0xFFEB5857)),
              const SizedBox(width: 10),
              ParagraphOneText(
                  text: title,
                  fillColor: const Color(0xFFEB5857),
                  fontWeight: FontWeight.bold),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const ParagraphTwoText(
                  text: 'Delete date:',
                  fillColor: Color(0xFFEB5857),
                  fontWeight: FontWeight.bold),
              const SizedBox(width: 10),
              ParagraphTwoText(
                  text: deleteDate != null ? deleteDate!.toFormattedDate() : '',
                  fillColor: const Color(0xFFEB5857)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const ParagraphTwoText(
                  text: 'Delete reason:',
                  fillColor: Color(0xFFEB5857),
                  fontWeight: FontWeight.bold),
              const SizedBox(width: 10),
              ParagraphTwoText(
                  text: deleteReason ?? '', fillColor: const Color(0xFFEB5857)),
            ],
          ),
        ],
      ), // Replace with your actual content
    );
  }
}
