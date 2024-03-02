import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokinia_lending_manager/components/buttons/my_fab_with_sub_title.dart';
import 'package:pokinia_lending_manager/pages/loans/selector/new_loan_page_old.dart';

class AddLoanModal extends StatelessWidget {
  const AddLoanModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        children: [
          MyFabWithSubTitle(
            subTitle: "New loan",
            onPressed: () => {
              showMaterialModalBottomSheet(
                enableDrag: true,
                isDismissible: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                context: context,
                builder: (context) => const NewLoanPageOld(),
              ),
            },
          ),
        ],
      ),
    );
  }
}
