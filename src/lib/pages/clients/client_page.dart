import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/buttons/my_fab.dart';
import 'package:pokinia_lending_manager/components/status_boxes/compact_status_box_component.dart';
import 'package:pokinia_lending_manager/components/status_boxes/regular_status_box_component.dart';
import 'package:pokinia_lending_manager/components/texts/amount_text.dart';
import 'package:pokinia_lending_manager/components/texts/header_four_text.dart';
import 'package:pokinia_lending_manager/components/texts/paragraph_one_text.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';

class ClientPage extends StatelessWidget {
  final ClientModel client;

  const ClientPage({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(client.name),
      ),
      body: Column(children: [
        // Image
        Image.asset(
          "assets/images/dummy_avatar.png",
          width: 48,
          height: 48,
        ),

        // Name
        HeaderFourText(text: client.name),

        // Status
        RegularStatusBoxComponent(paymentStatus: client.paymentStatus),

        //Contact buttons
        Row(
          children: [
            // Call button
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {},
            ),

            // Message button
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {},
            ),

            // Email button
            IconButton(
              icon: const Icon(Icons.email),
              onPressed: () {},
            ),
          ],
        ),

        // Phone number
        Row(
          children: [
            const Icon(Icons.phone),
            ParagraphOneText(text: client.phoneNumber)
          ],
        ),

        // Address
        Row(
          children: [
            const Icon(Icons.location_on),
            ParagraphOneText(text: client.phoneNumber),
          ],
        ),

        //Edit button
        const Text("Edit"),

        // Separator
        const Divider(color: Colors.grey, thickness: 2),

        // Loans
        ListView.builder(
          itemCount: client.loans.length,
          itemBuilder: (context, index) {
            var loan = client.loans[index];

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFF8F8F8),
                  border: const Border(
                    bottom: BorderSide(
                      color: Color(0xFFD2DEE0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CompactStatusBoxComponent(paymentStatus: loan.paymentStatus),
                          const SizedBox(width: 10),
                          AmountText(amount: loan.amount),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            );
          },
          shrinkWrap: true,
        ),

        // New loan
        MyFab(subTitle: "New loan", onPressed: () {}),
      ]),
    );
  }
}
