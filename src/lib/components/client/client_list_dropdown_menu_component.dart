import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:provider/provider.dart';

class ClientListDropdownMenu extends StatelessWidget {
  final TextEditingController controller;
  final Function(ClientModel? clientSelected) onClientSelected;
  final bool enabled;
  ClientModel? selectedClient;

  ClientListDropdownMenu(
      {super.key,
      required this.controller,
      required this.onClientSelected,
      this.selectedClient,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientService>(
      builder: (context, clientService, _) {
        return DropdownButtonFormField(
          isExpanded: true,
          onChanged: (client) {
            onClientSelected(client);
          },
          validator: (value) {
            if (value == null) {
              return 'Please select a client';
            }
            return null;
          },
          items: [
            for (var client in clientService.clients)
              DropdownMenuItem(
                value: client,
                child: Text(client.name)
              ),
          ],
          value: selectedClient,
          decoration: InputDecoration(
            labelText: 'Client',
            filled: true,
            fillColor: const Color(0xFFE5EAEB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
