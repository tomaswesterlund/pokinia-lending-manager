import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_fab.dart';
import 'package:pokinia_lending_manager/components/status_boxes/client_payment_status/compact_client_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/pages/clients/client_page.dart';
import 'package:pokinia_lending_manager/pages/clients/new_client_page.dart';

class ClientList extends StatelessWidget {
  final List<ClientModel> clients;
  const ClientList({super.key, required this.clients});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final ClientModel client = clients[index];

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
                    color: const Color(0xFFF8F8F8),
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
                      CompactClientPaymentStatusBoxComponent(
                          paymentStatus: client.paymentStatus)
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
