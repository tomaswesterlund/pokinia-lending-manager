import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/client.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:pokinia_lending_manager/providers/user_settings_provider.dart';
import 'package:provider/provider.dart';

class ClientListDropdownMenu extends StatelessWidget {
  final TextEditingController controller;
  final Function(Client? clientSelected) onClientSelected;
  final bool enabled;
  Client? selectedClient;

  ClientListDropdownMenu(
      {super.key,
      required this.controller,
      required this.onClientSelected,
      this.selectedClient,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ClientProvider, UserSettingsProvider>(
      builder: (context, clientProvider, userSettingsProvider, _) {
        var userId = userSettingsProvider.supabase.auth.currentUser!.id;
          var userSettings = userSettingsProvider.getByUserId(userId);
          var clients = clientProvider.getClients(showDeleted: userSettings.showDeletedClients);
          clients.sort((a, b) => a.name.compareTo(b.name));

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
            for (var client in clients)
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
