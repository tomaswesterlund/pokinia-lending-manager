import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/components/buttons/fabs.dart';
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
    return Scaffold(
      body: Consumer<ClientService>(
        builder: (context, clientService, _) {
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: HeaderTwoText(text: "Clients"),
                scrolledUnderElevation: 0,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final ClientModel client = clientService.clients[index];

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
                            CompactClientPaymentStatusBoxComponent(
                                paymentStatus: client.paymentStatus)
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: clientService.clients.length,
                ),
              )
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: getDefaultFab(
        onPressed: () => showMaterialModalBottomSheet(
          enableDrag: true,
          isDismissible: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          context: context,
          builder: (context) => const NewClientPage(),
        ),
      ),
    );
  }
}
