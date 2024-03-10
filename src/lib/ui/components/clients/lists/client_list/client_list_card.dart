import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/client.dart';
import 'package:pokinia_lending_manager/ui/components/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/ui/components/boxes/base_box.dart';
import 'package:pokinia_lending_manager/ui/components/status_boxes/payment_status/squared_payment_status_box_component.dart';
import 'package:pokinia_lending_manager/ui/components/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/ui/components/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/ui/pages/clients/client_page.dart';
import 'package:string_capitalize/string_capitalize.dart';

class ClientListCard extends StatelessWidget {
  final Client client;
  const ClientListCard({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => ClientPage(clientId: client.id))),
      child: BaseBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MyAvatarComponent(
                      name: client.name,
                      avatarImagePath: client.avatarImagePath),
                  const SizedBox(width: 10),
                  HeaderFourText(text: client.name),
                ],
              ),
              Column(
                children: [
                  SquaredPaymentStatusBoxComponent(
                      paymentStatus: client.paymentStatus),
                      const SizedBox(height: 4),
                      ParagraphTwoText(
                        text: client.paymentStatus.name.toString().capitalize(),
                        fillColor: const Color(0xFF9EA6A7),
                      ),
                ],
              )
            ],
          )),
    );
  }
}
