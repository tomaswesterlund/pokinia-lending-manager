import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/texts/header_three_text.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:provider/provider.dart';

class NewClientPage extends StatelessWidget {
  NewClientPage({super.key});

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Foto

          // Agregar foto

          Column(
            children: [
              const Text("New Client Page"),

              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: MyTextField(
                      labelText: 'Name', controller: _nameController)),

              // Phone number
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: MyTextField(
                    labelText: 'Phone number',
                    controller: _phoneNumberController,
                  )),

              // Address
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: MyTextField(
                    labelText: 'Address',
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
                onPressed: () {
                  String name = _nameController.text;
                  String phoneNumber = _phoneNumberController.text;
                  String address = _addressController.text;

                  // clientProvider.addClient(
                  //     id: name.replaceAll(' ', ''),
                  //     name: name,
                  //     phoneNumber: phoneNumber,
                  //     address: address);
                  // var client = clientProvider.getLatestClientBasedOnName(name);

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (ctx) => ClientPage(client: client!)));
                }),
          ),
          // Button: Client already exists
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const MyTextField(
      {super.key, required this.labelText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF979797)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF979797)),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: const Color(0xFFE5EAEB),
          labelText: labelText),
    );
  }
}
