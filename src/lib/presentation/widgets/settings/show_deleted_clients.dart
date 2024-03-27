import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/domain/services/toast_service.dart';
import 'package:pokinia_lending_manager/view_models/widgets/settings/show_deleted_clients_view_model.dart';
import 'package:pokinia_lending_manager/view_models/widgets/shared/unexpected_error.dart';
import 'package:provider/provider.dart';

class ShowDeletedClients extends StatelessWidget {
  const ShowDeletedClients({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowDeletedClientsViewModel>(
      builder: (context, vm, _) {
        return FutureBuilder(
          future: vm.getDeletedClients(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const UnexpectedError();
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ParagraphTwoText(text: 'Show deleted clients'),
                      CupertinoSwitch(
                        value: vm.showDeletedClients!,
                        onChanged: (value) {
                          vm.updateShowDeletedClients(value).fold(
                              (error) => ToastService()
                                  .showErrorToast('Could not update settings'),
                              (success) => null);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const UnexpectedError();
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
