import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/data/client.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/services/log_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClientProvider extends ChangeNotifier {
  final LogService _logger = LogService('ClientProvider');
  final supabase = Supabase.instance.client;
  bool loaded = false;

  final List<Client> _clients = [];

  void startListener(Function(String source) onLoaded) {
    supabase
        .from('clients')
        .stream(primaryKey: ['id']).listen(((List<Map<String, dynamic>> data) {
      var clients = data.map((map) => Client.fromMap(map)).toList();
      _clients.clear();
      _clients.addAll(clients);

      if (!loaded) {
        loaded = true;
        onLoaded('clientService');
      }

      notifyListeners();
    })).onError((error, stackTrace) {
      _logger.e('startListener', 'Error listening to clients: $error');
    });
  }

  Client getById(String id) {
    return _clients.firstWhere((client) => client.id == id);
  }

  List<Client> getClients({bool showDeleted = false}) {
    if (showDeleted) {
      return _clients;
    } else {
      return _clients.where((client) => !client.deleted).toList();
    }
  }

  Future<Response> createClient(
      {required String organizationId,
      required String name,
      String? phoneNumber,
      String? address,
      String? avatarImagePath}) async {
    try {
      _logger.i('createClient', 
          'Adding client with organizationId: $organizationId, name: $name, phoneNumber: $phoneNumber, address: $address, avatarImagePath: $avatarImagePath');

      var params = {
        'v_organization_id': organizationId,
        'v_name': name,
        'v_phone_number': phoneNumber,
        'v_address': address,
        'v_avatar_image_path': avatarImagePath ?? ''
      };

      await supabase.rpc('create_client', params: params);

      return Response.success();
    } catch (e) {
      _logger.e('createClient', 'Error creating client: $e');
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
      _logger.e('deleteClient', 'Error deleting client: $e');
      return Response.error(e.toString());
    }
  }

  Future<Response> undeleteClient(String id) async {
    try {
      var params = {'v_client_id': id};

      await supabase.rpc('undelete_client', params: params);

      return Response.success();
    } catch (e) {
      _logger.e('undeleteClient', 'Error un-deleting client: $e');
      return Response.error(e.toString());
    }
  }
}
