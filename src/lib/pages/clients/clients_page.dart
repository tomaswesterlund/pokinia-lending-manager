import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/client/client_list_component.dart';
import 'package:pokinia_lending_manager/components/client/empty_list_client_component.dart';
import 'package:pokinia_lending_manager/components/texts/header_three_text.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:provider/provider.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientProvider>(
      builder: (_, clientProvider, child) => Scaffold(
        appBar: AppBar(
          title: const HeaderThreeText(text: "Clients"),
        ),
        body: clientProvider.hasClients == true
            ? const ClientList()
            : const EmptyClientList(),
      ),
    );
  }
}
