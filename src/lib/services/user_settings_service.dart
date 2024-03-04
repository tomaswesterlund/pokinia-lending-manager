import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/models/data/user_settings.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserSettingsService extends ChangeNotifier {
  final Logger _logger = getLogger('UserSettingsService');
  final supabase = Supabase.instance.client;

  String? userId;

  UserSettings? _userSettings;
  UserSettings? get userSettings => _userSettings;

  UserSettingsService() {
    listenToUserSettings();
  }

  void listenToUserSettings() {
    supabase.from('user_settings').stream(primaryKey: ['id']).listen((data) {
      var list = data.map((map) => UserSettings.fromMap(map)).toList();

      if (userId != null) {
        var userSettings =
            list.firstWhere((element) => element.userId == userId);
        _userSettings = userSettings;
      }

      notifyListeners();
    });
  }

  void setUserId(String id) {
    userId = id;
  }

  void setSelectedCustomer(String customerId) async {
    try {
      _logger.i('Setting selected customer to: $customerId');

      await supabase.from('user_settings').insert(
        {
          'user_id': userId,
          'selected_customer_id': customerId,
        },
      );

      notifyListeners();
    } catch (e) {
      _logger.e('Error adding client: $e');
    }
  }
}
