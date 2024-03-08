import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/components/buttons/fabs.dart';
import 'package:pokinia_lending_manager/components/client/empty_list_client_component.dart';
import 'package:pokinia_lending_manager/components/my_drawer.dart';
import 'package:pokinia_lending_manager/components/status_boxes/payment_status/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/models/data/client.dart';
import 'package:pokinia_lending_manager/pages/clients/client_page.dart';
import 'package:pokinia_lending_manager/pages/clients/new_client_page.dart';
import 'package:pokinia_lending_manager/services/client_service.dart';
import 'package:provider/provider.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  bool _showDeleted = false;

  void _onShowDeletedChanged(bool newValue) {
    setState(() {
      _showDeleted = newValue;
    });
  }

  List<Client> _getClients() {
    final clientService = Provider.of<ClientService>(context, listen: false);
    return _showDeleted ? clientService.clients : clientService.activeClients;
  }

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
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Show deleted"),
                    const SizedBox(width: 12),
                    CupertinoSwitch(
                        value: _showDeleted, onChanged: _onShowDeletedChanged)
                  ],
                ),
              ),
              _getClients().isEmpty
                  ? const SliverFillRemaining(
                      child: Center(child: EmptyClientList()),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final Client client =
                              _getClients()[index];

                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        ClientPage(clientId: client.id))),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      MyAvatarComponent(client: client),
                                      const SizedBox(width: 10),
                                      HeaderFourText(text: client.name),
                                    ],
                                  ),
                                  SquaredPaymentStatusBoxComponent(
                                      paymentStatus: client.paymentStatus)
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: _getClients().length,
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
          builder: (context) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const NewClientPage(),
          ),
        ),
      ),
      endDrawer: Drawer(
        child: MyDrawer(),
      ),
    );
  }
}
