import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/presentation/widgets/settings/show_deleted_clients.dart';

class ClientSettings extends StatelessWidget {
  const ClientSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client settings'),
      ),
      body: const Column(
        children: [
          ShowDeletedClients(),
        ],
      ),
    );
  }
}
