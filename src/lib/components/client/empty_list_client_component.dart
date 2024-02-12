import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_fab.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_five_text.dart';
import 'package:pokinia_lending_manager/components/texts/my_sub_heading_text.dart';
import 'package:pokinia_lending_manager/pages/clients/new_client_page.dart';

class EmptyClientList extends StatelessWidget {
  const EmptyClientList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset('assets/images/empty_list_clients.png'),
              const SizedBox(height: 25),
              const HeaderFiveText(text: "No clients were found."),
              const MySubHeadingText(
                  text: "Would you like to create a new client?"),
              const SizedBox(height: 100),
            ],
          ),
        );
  }
}