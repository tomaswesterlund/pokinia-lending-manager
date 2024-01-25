import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/status_boxes/compact_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/header_four_text.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/pages/clients/client_page.dart';
import 'package:pokinia_lending_manager/pages/clients/new_client_page.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:provider/provider.dart';

class ClientList extends StatelessWidget {
  const ClientList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientProvider>(
      builder: (_, clientProvider, child) => Scaffold(
        body: ListView.builder(
          itemCount: clientProvider.clients.length,
          itemBuilder: (context, index) {
            final ClientModel client = clientProvider.clients[index];

            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ClientPage(client: client))),
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                // height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFD2DEE0),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/dummy_avatar.png",
                          width: 48,
                          height: 48,
                        ),
                        const SizedBox(width: 10),
                        HeaderFourText(text: client.name),
                      ],
                    ),
                    CompactStatusBoxComponent(paymentStatus: client.paymentStatus)
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewClientPage(),
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
