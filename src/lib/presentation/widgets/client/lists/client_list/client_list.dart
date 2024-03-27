import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/presentation/widgets/client/lists/client_list/client_list_card.dart';

class ClientList extends StatelessWidget {
  final List<ClientEntity> clients;

  const ClientList({super.key, required this.clients});

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
