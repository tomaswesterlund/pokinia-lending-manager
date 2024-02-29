import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/pages/customers/new_customer_page.dart';
import 'package:pokinia_lending_manager/pages/main_page.dart';
import 'package:pokinia_lending_manager/services/customer_service.dart';
import 'package:pokinia_lending_manager/services/user_settings_service.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerPage extends StatelessWidget {
  final supabase = Supabase.instance.client;

  CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body: Consumer2<CustomerService, UserSettingsService>(
        builder: (context, customerService, userSettingsService, _) {
          var customers = customerService.customers;
          
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  var customer = customers[index];

                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(customer.name),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      userSettingsService.setSelectedCustomer(customer.id);
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                      );
                    },
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewCustomerPage(),
                    ),
                  );
                },
                child: const Text("New customer"),
              )
            ],
          );
        },
      ),
    );
  }
}
