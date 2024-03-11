import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/ui/components/my_drawer.dart';
import 'package:pokinia_lending_manager/ui/components/texts/headers/header_two_text.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const HeaderTwoText(text: "Reports"),
          automaticallyImplyLeading: false,
        ),
        body: const Center(
          child: Text("Report page"),
        ),
        endDrawer: Drawer(
          child: MyDrawer(),
        ));
  }
}
