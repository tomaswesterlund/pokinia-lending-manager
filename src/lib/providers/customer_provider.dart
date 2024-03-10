import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/customer.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerProvider extends ChangeNotifier {
  final _logger = getLogger('CustomerService');
  final supabase = Supabase.instance.client;
  bool loaded = false;

  final List<Customer> _customers = [];
  List<Customer> get customers => _customers;

  void startListener(Function(String source) onLoaded) {
    supabase.from('customers').stream(primaryKey: ['id']).listen((data) {
      var customers = data.map((map) => Customer.fromMap(map)).toList();
      _customers
        ..clear()
        ..addAll(customers);

      if (!loaded) {
        loaded = true;
        onLoaded('customerService');
      }

      notifyListeners();
    });
  }

  Customer getCustomerById(String id) {
    return _customers.firstWhere((element) => element.id == id);
  }

  Future<void> createCustomer(String name) async {
    try {
      await supabase.from('customers').insert({'name': name});
    } catch (e) {
      _logger.e(e);
    }
  }
}
