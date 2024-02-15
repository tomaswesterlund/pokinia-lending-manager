import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/compact_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/pages/clients/client_page.dart';

class ClientList extends StatelessWidget {
  final List<ClientModel> clients;
  const ClientList({super.key, required this.clients});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
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
                            MyAvatarComponent(client: client),
                            const SizedBox(width: 10),
                            HeaderFourText(text: client.name),
                          ],
                        ),
                        CompactPaymentStatusBox(
                            paymentStatus: client.paymentStatus)
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
