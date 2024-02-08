import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/client/client_list_component.dart';
import 'package:pokinia_lending_manager/components/client/empty_list_client_component.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:provider/provider.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {

    var clientService = Provider.of<ClientService>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const HeaderTwoText(text: "Clients"),
        ),
        body: StreamBuilder<List<ClientModel>>(
          stream: clientService.getClientsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                List<ClientModel> clients = snapshot.data!;
                return  ClientList(clients: clients);
              } else {
                return const EmptyClientList();
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
  }
}
