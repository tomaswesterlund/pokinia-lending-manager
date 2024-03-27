import 'package:supabase_flutter/supabase_flutter.dart';

class LogService {
  final supabase = Supabase.instance.client;
  final String className;
  final String _source = 'flutter_client_app';

  LogService(this.className);

  void log(String severity, String methodName, String description) async {
    try {
      var response = await supabase.from('log').insert(
        {
          'source': _source,
          'severity': severity,
          'method_name': '$className.$methodName',
          'description': description,
          'user_id': supabase.auth.currentUser?.id,
        },
      );
    } catch (e) {
      print('Error logging: $e');
    }
  }

  void i(String methodName, String description) {
    log('info', methodName, description);
  }

  void e(String methodName, String description) {
    log('exception', methodName, description);
  }
}
