import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/util/date_extensions.dart';

class SelectDateInput extends StatefulWidget {
  final String title;
  final String? helpText;
  final bool isProcessing;
  final Function(DateTime) onDateSelected;

  const SelectDateInput({
    super.key,
    required this.title,
    this.helpText,
    required this.isProcessing,
    required this.onDateSelected,
  });

  @override
  State<SelectDateInput> createState() => _SelectDateInputState();
}

class _SelectDateInputState extends State<SelectDateInput> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _showDateTimePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateSelected(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ParagraphOneText(text: widget.title, fontWeight: FontWeight.bold),
              if (widget.helpText != null)
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Help'),
                                content: Text(widget.helpText!),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.help, color: Color(0xFF979797))),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    _showDateTimePicker(context);
                  },
                  icon: const Icon(Icons.calendar_month)),
              ParagraphOneText(text: _selectedDate.toFormattedDate()),
            ],
          ),
        ],
      ),
    );
  }
}
