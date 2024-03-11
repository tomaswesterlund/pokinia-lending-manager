import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/organization.dart';
import 'package:pokinia_lending_manager/providers/organization_provider.dart';
import 'package:pokinia_lending_manager/providers/user_settings_provider.dart';
import 'package:pokinia_lending_manager/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyDrawer extends StatelessWidget {
  final supabase = Supabase.instance.client;
  final AuthService _authService = AuthService();
  String dropdownValue = 'One';
  MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<OrganizationProvider, UserSettingsProvider>(
      builder: (context, organizationProvider, userSettingsProvider, child) {

        var userId = supabase.auth.currentUser!.id;
        var organizations = organizationProvider.organizations;
        var userSettings = userSettingsProvider.getByUserId(supabase.auth.currentUser!.id);

        
        
        return Center(
          child: Column(
            children: [
              DropdownButton<String>(
                value: userSettings.selectedOrganzationId,
                onChanged: (String? newValue) {
                  userSettingsProvider.setSelectedOrganizationId(userId, newValue!);
                },  
                items: organizations
                    .map<DropdownMenuItem<String>>((Organization organization) {
                  return DropdownMenuItem<String>(
                    value: organization.id,
                    child: Text(organization.name),
                  );
                }).toList(),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                  onPressed: () {
                    _authService.signOut();
                  },
                  child: const Text("Log out")),
            ],
          ),
        );
      },
    );
  }
}
