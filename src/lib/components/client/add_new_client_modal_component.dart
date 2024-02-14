import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/buttons/my_cta_button.dart';
import 'package:pokinia_lending_manager/components/buttons/my_fab.dart';
import 'package:pokinia_lending_manager/pages/clients/new_client_page.dart';

class AddNewClientModal extends StatelessWidget {
  const AddNewClientModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        children: [
          MyFab(
              subTitle: "New client",
              onPressed: () => {
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
                    ),
                  }),
        ],
      ),
    );
  }
}