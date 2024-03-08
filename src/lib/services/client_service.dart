import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/models/data/client.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClientService extends ChangeNotifier {
  final Logger _logger = getLogger('ClientService');
  final supabase = Supabase.instance.client;
  bool loaded = false;

  final List<Client> _clients = [];
  List<Client> get clients => _clients;
  List<Client> get activeClients =>
      _clients.where((client) => !client.deleted).toList();

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

      loaded = true;

      notifyListeners();
    })).onError((error, stackTrace) {
      _logger.e('Error listening to clients: $error');
    });
  }

  Client getClientById(String id) {
    return clients.firstWhere((client) => client.id == id);
  }

  Future<Response> createClient(
      {required String customerId,
      required String name,
      required phoneNumber,
      String? address,
      String? avatarImagePath}) async {
    try {
      _logger.i(
          'Adding client with customerId: $customerId, name: $name, phoneNumber: $phoneNumber, address: $address, avatarImagePath: $avatarImagePath');

      var params = {
        'v_customer_id': customerId,
        'v_name': name,
        'v_phone_number': phoneNumber,
        'v_address': address,
        'v_avatar_image_path': avatarImagePath ?? ''
      };

      await supabase.rpc('create_client', params: params);

      return Response.success();
    } catch (e) {
      _logger.e('Error adding client: $e');
      return Response.error(e.toString());
    }
  }

  Future<Response> deleteClient(String id, String deleteReason) async {
    try {
      var params = {
        'v_client_id': id,
        'v_delete_date': DateTime.now().toIso8601String(),
        'v_delete_reason': deleteReason,
      };

      await supabase.rpc('delete_client', params: params);

      return Response.success();
    } catch (e) {
      _logger.e('Error deleting client: $e');
      return Response.error(e.toString());
    }
  }

  Future<Response> undeleteClient(String id) async {
    try {
      var params = {'v_client_id': id};

      await supabase.rpc('undelete_client', params: params);

      return Response.success();
    } catch (e) {
      _logger.e('Error un-deleting client: $e');
      return Response.error(e.toString());
    }
  }
}
