import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/services/customer_service.dart';

class NewCustomerPage extends StatelessWidget {
  NewCustomerPage({super.key});

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Customer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextFormField(
            labelText: "Name",
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              CustomerService().createCustomer(_nameController.text);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
