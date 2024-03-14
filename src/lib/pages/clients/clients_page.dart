import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/buttons/fabs.dart';
import 'package:pokinia_lending_manager/components/clients/empty_list_client_component.dart';
import 'package:pokinia_lending_manager/components/clients/lists/client_list/client_list.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/pages/clients/new_client_page.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:provider/provider.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ClientProvider>(
        builder: (context, provider, _) {
          var clients = provider.clients;
          clients.sort((a, b) => a.name.compareTo(b.name));

          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                automaticallyImplyLeading: false,
                title: HeaderTwoText(text: "Clients"),
                scrolledUnderElevation: 0,
              ),
              clients.isEmpty
                  ? const SliverFillRemaining(
                      child: Center(child: EmptyClientList()),
                    )
                  : ClientList(clients: clients)
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
    );
  }
}
