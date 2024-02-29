import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/models/client.dart';
import 'package:pokinia_lending_manager/models/repsonse.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClientService extends ChangeNotifier {
  final Logger _logger = getLogger('ClientService');
  final supabase = Supabase.instance.client;

  final List<Client> _clients = [];
  List<Client> get clients => _clients;

  ClientService() {
    listenToClients();
  }

  void listenToClients() {
    supabase
        .from('clients')
        .stream(primaryKey: ['id']).listen(((List<Map<String, dynamic>> data) {
      var clients = data.map((map) => Client.fromMap(map)).toList();
      _clients.clear();
      _clients.addAll(clients);
      notifyListeners();
    })).onError((error, stackTrace) {
      _logger.e('Error listening to clients: $error');
    });
  }

  Client getClientById(String id) {
    return clients.firstWhere((client) => client.id == id);
  }

  Future<Response> addClient(
      {required String customerId,
      required String name,
      required phoneNumber,
      String? address,
      String? avatarImagePath}) async {
    try {
      _logger.i(
          'Adding client with customerId: $customerId, name: $name, phoneNumber: $phoneNumber, address: $address, avatarImagePath: $avatarImagePath');

      await supabase.from('clients').insert(
        {
          'customer_id': customerId,
          'name': name,
          'phone_number': phoneNumber,
          'address': address,
          'avatar_image_path': avatarImagePath ?? '',
          'payment_status': 'unknown'
        },
      );

      return Response(statusCode: 200);
    } catch (e) {
      _logger.e('Error adding client: $e');
      return Response(statusCode: 500, body: e.toString());
    }
  }
}
