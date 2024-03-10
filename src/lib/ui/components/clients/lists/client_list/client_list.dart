import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/client.dart';
import 'package:pokinia_lending_manager/ui/components/clients/lists/client_list/client_list_card.dart';

class ClientList extends StatelessWidget {
  List<Client> clients;

  ClientList({super.key, required this.clients});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final client = clients[index];

          return ClientListCard(client: client);
        },
        childCount: clients.length,
      ),
    );
  }
}
