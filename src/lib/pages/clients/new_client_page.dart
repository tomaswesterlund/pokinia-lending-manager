import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/input/my_text_form_field.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';
import 'package:provider/provider.dart';

class NewClientPage extends StatefulWidget {
  const NewClientPage({super.key});

  @override
  State<NewClientPage> createState() => _NewClientPageState();
}

class _NewClientPageState extends State<NewClientPage> {
  bool _isProcessing = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var clientService = Provider.of<ClientService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const HeaderThreeText(text: 'New client'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Foto

            // Agregar foto

            Column(
              children: [

                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: MyTextFormField(
                        labelText: 'Name',
                        validator: (value) {
                          if (value.isNullOrEmpty()) {
                            return "Name can't be empty";
                          }

                          return null;
                        },
                        controller: _nameController)),

                // Phone number
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: MyTextFormField(
                      labelText: 'Phone number',
                      validator: (value) {
                          if (value.isNullOrEmpty()) {
                            return "Phone number can't be empty";
                          }

                          return null;
                        },
                      controller: _phoneNumberController,
                    )),

                // Address
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: MyTextFormField(
                      labelText: 'Address',
                      validator: (value) {
                        return null;
                      },
                      controller: _addressController,
                    )),
              ],
            ),
            // Name

            // Button: Create new client
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: MyCtaButton(
                text: "New client",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String name = _nameController.text;
                    String phoneNumber = _phoneNumberController.text;
                    String address = _addressController.text;

                    _isProcessing = true;
                    var response = await clientService.createClient(
                        name: name, phoneNumber: phoneNumber, address: address);
                    _isProcessing = false;

                    if (response.statusCode == 200) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please validate your input!"),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            // Button: Client already exists
          ],
        ),
      ),
    );
  }
}
