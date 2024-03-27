import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/view_models/widgets/client/client_list_drop_down_menu_view_model.dart';
import 'package:provider/provider.dart';

class ClientListDropdownMenu extends StatelessWidget {
  final Function(ClientEntity?) onClientSelected;
  const ClientListDropdownMenu({super.key, required this.onClientSelected});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientListDropdownMenuViewModel>(
      builder: (context, vm, _) {
        var clients = vm.getAllClients();

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
              DropdownMenuItem(value: client, child: Text(client.name)),
          ],
          value: vm.selectedClient,
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
