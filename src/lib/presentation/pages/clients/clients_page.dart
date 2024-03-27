import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/universal/buttons/fabs.dart';
import 'package:pokinia_lending_manager/components/universal/texts/headers/header_two_text.dart';
import 'package:pokinia_lending_manager/presentation/pages/clients/new_client_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/client/empty_list_client_component.dart';
import 'package:pokinia_lending_manager/presentation/widgets/client/lists/client_list/client_list.dart';
import 'package:pokinia_lending_manager/view_models/pages/client/clients_page_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/shared/unexpected_error.dart';
import 'package:provider/provider.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClientsPageViewModel>(
      builder: (context, vm, _) {
        return vm.getClients().fold(
              (error) => const UnexpectedError(),
              (clients) => Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      title: HeaderTwoText(text: vm.title),
                      scrolledUnderElevation: 0,
                    ),
                    clients.isEmpty
                        ? const SliverFillRemaining(
                            child: Center(child: EmptyClientList()),
                          )
                        : ClientList(clients: clients)
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
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
                      child: NewClientPage(),
                    ),
                  ),
                ),
              ),
            );
      },
    );
  }
}
