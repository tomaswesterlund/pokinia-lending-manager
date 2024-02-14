import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/buttons/my_avatar_component.dart';
import 'package:pokinia_lending_manager/components/client/empty_list_client_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/client_payment_status/compact_client_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/pages/clients/client_page.dart';
import 'package:pokinia_lending_manager/pages/clients/new_client_page.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:provider/provider.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var clientService = Provider.of<ClientService>(context, listen: false);

    return Scaffold(
      body: StreamBuilder(
        stream: clientService.getClientsStream(),
        builder: (context, clientsSnapshot) {
          if (clientsSnapshot.hasData) {
            if (clientsSnapshot.data!.isNotEmpty) {
              List<ClientModel> clients = clientsSnapshot.data!;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: const HeaderTwoText(text: "Clients"),
                    scrolledUnderElevation: 0,
                    floating: true,
                    actions: [
                      IconButton(
                        onPressed: () {
                          showMaterialModalBottomSheet(
                            enableDrag: false,
                            isDismissible: false,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            context: context,
                            builder: (context) => const NewClientPage(),
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 28.0,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final ClientModel client = clients[index];

                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      ClientPage(client: client))),
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
                                CompactClientPaymentStatusBoxComponent(
                                    paymentStatus: client.paymentStatus)
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: clients.length,
                    ),
                  )
                ],
              );
            } else if (clientsSnapshot.data!.isEmpty) {
              return const EmptyClientList();
            } else {
              // Error (?)
              return const Center(child: CircularProgressIndicator());
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
