import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/headers/header_four_text.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_two_text.dart';
import 'package:pokinia_lending_manager/core/util/payment_status_extensions.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/presentation/pages/clients/client_page.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/avatars/my_avatar_component.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/boxes/base_box.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/payment_status_boxes/squared_payment_status_box_component.dart';

class ClientListCard extends StatelessWidget {
  final ClientEntity client;
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
                  name: client.name, avatarImagePath: client.avatarImagePath),
              const SizedBox(width: 10),
              HeaderFourText(text: client.name),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SquaredPaymentStatusBoxComponent(
                  paymentStatus: client.paymentStatus),
              const SizedBox(height: 4),
              ParagraphTwoText(
                text: client.paymentStatus.toFormatted(),
                color: const Color(0xFF9EA6A7),
              ),
            ],
          )
        ],
      )),
    );
  }
}
