import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:provider/provider.dart';

class ClientListDropdownMenu extends StatelessWidget {
  final TextEditingController controller;
  final Function(ClientModel? clientSelected) onClientSelected;
  ClientModel? selectedClient;
  ClientListDropdownMenu(
      {super.key, required this.controller, required this.onClientSelected, this.selectedClient});

  @override
  Widget build(BuildContext context) {
    ClientService clientService =
        Provider.of<ClientService>(context, listen: false);

    return StreamBuilder<List<ClientModel>>(
      stream: clientService.getClientsStream(),
      builder: (context, clientsSnapshot) {
        if (clientsSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var clients = clientsSnapshot.data!;

        return DropdownMenu(
          // enableSearch: true,
          // enableFilter: true,
          controller: controller,
          initialSelection: selectedClient,
          dropdownMenuEntries: <DropdownMenuEntry<ClientModel>>[
            for (var client in clients)
              DropdownMenuEntry(
                value: client,
                label: client.name,
              )
          ],
          onSelected: (value) {
            selectedClient = value;
            onClientSelected(value);
          },
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.red,
            iconColor: Colors.blue,
            focusColor: Colors.green,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
