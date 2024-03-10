import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/models/data/organization.dart';
import 'package:pokinia_lending_manager/models/data/repsonse.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrganizationProvider extends ChangeNotifier {
  final Logger _logger = getLogger('OrganizationService');
  final supabase = Supabase.instance.client;
  bool loaded = false;

  final List<Organization> _organizations = [];
  List<Organization> get organizations => _organizations;

  void startListener(Function(String source) onLoaded) {
    supabase
        .from('organizations')
        .stream(primaryKey: ['id']).listen(((List<Map<String, dynamic>> data) {
      var organizations = data.map((map) => Organization.fromMap(map)).toList();
      _organizations.clear();
      _organizations.addAll(organizations);

      if (!loaded) {
        loaded = true;
        onLoaded('organizationService');
      }

      notifyListeners();
    })).onError((error, stackTrace) {
      _logger.e('Error listening to organizations: $error');
    });
  }

  Organization getOrganizationById(String id) {
    return _organizations.firstWhere((element) => element.id == id);
  }

  Future<Response> createOrganization(String name) async {
    try {
      _logger.i('Creating organization: $name');

      var data = await supabase.from('organizations').insert({
        'name': name,
      }).select('id');

      return Response(statusCode: 200, message: 'data: $data', data: data);
    } catch (e) {
      _logger.e('Error creating organization: $e');
      return Response.error(e.toString());
    }
  }
}
