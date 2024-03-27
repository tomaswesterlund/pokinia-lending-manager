import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/buttons/fabs.dart';
import 'package:pokinia_lending_manager/components/universal/texts/headers/header_three_text.dart';
import 'package:pokinia_lending_manager/presentation/pages/loans/selector/select_loan_type_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/client/client_app_bar.dart';
import 'package:pokinia_lending_manager/presentation/widgets/client/client_contact.dart';
import 'package:pokinia_lending_manager/presentation/widgets/client/client_deleted_box.dart';
import 'package:pokinia_lending_manager/presentation/widgets/client/lists/client_loan_list/client_loan_list.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_row.dart';
import 'package:pokinia_lending_manager/view_models/pages/client/client_page_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ClientPage extends StatelessWidget {
  final String clientId;

  const ClientPage({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientPageViewModel>(
      builder: (context, vm, _) {
        var client = vm.getClientById(clientId);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              ClientAppBar(
                  clientId: clientId,
                  title: 'Client',
                  isDeleted: client.deleted),
              MultiSliver(
                children: [
                  Column(
                    children: [
                      ClientDeletedBox(client: client),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyAvatarComponent(
                              name: client.name,
                              avatarImagePath: client.avatarImagePath),
                          const SizedBox(width: 16.0),
                          HeaderThreeText(text: client.name),
                        ],
                      ),
                      PaymentStatusRow(paymentStatus: client.paymentStatus)
                          .paddingAll(24.0),
                      ClientContact(client: client)
                    ],
                  ),
                  const Center(child: HeaderThreeText(text: "Loans")),
                  ClientLoanList(clientId: clientId),
                  const SizedBox(height: 128.0)
                ],
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: getDefaultFab(onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SelectLoanTypePage()));
          }),
        );
      },
    );
  }
}
