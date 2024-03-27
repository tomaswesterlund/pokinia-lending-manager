import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/universal/texts/paragraphs/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';

class ClientContact extends StatelessWidget {
  final ClientEntity client;

  const ClientContact({super.key, required this.client});

  bool get _hasPhoneNumber =>
      client.phoneNumber != null && client.phoneNumber!.isNotEmpty;
  bool get _hasAddress => client.address != null && client.address!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (client.phoneNumber == null && client.address == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        _getContactButtonsWidget(),
        _getContactInformationWidget(client.phoneNumber, client.address),
      ],
    );
  }

  Widget _getContactButtonsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _hasPhoneNumber
            ? Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2F2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.call),
                  color: const Color(0xFF008080),
                  onPressed: () {},
                ),
              )
            : const SizedBox.shrink(),
        _hasPhoneNumber
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2EEE3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.message),
                  color: const Color(0xFFEAB308),
                  onPressed: () {},
                ),
              )
            : const SizedBox.shrink(),
        _hasAddress
            ? Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF2E3E3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.map),
                  color: const Color(0xFFEB5857),
                  onPressed: () {},
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _getContactInformationWidget(String? phoneNumber, String? address) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 0.0),
      child: Column(
        children: [
          _hasPhoneNumber
              ? Row(
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(width: 8.0),
                    ParagraphOneText(
                        text: phoneNumber!, fontWeight: FontWeight.bold)
                  ],
                )
              : const SizedBox.shrink(),
          _hasPhoneNumber && _hasAddress
              ? const SizedBox(height: 16.0)
              : const SizedBox.shrink(),
          _hasAddress
              ? Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(width: 8.0),
                    ParagraphOneText(
                        text: address ?? "", fontWeight: FontWeight.bold),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
