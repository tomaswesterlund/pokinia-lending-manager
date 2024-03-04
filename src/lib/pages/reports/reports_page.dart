import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/components/my_drawer.dart';
import 'package:pokinia_lending_manager/components/texts/headers/header_two_text.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HeaderTwoText(text: "Reports"),
      ),
      body: const Center(
        child: Text("Report page"),
      ),
      endDrawer:  Drawer(
        child: MyDrawer(),
      )
    );
  }
}