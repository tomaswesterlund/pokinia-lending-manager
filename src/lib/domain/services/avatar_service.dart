import 'dart:io';

import 'package:pokinia_lending_manager/domain/services/log_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class AvatarService {
  final LogService _logger = LogService('AvatarService');
  final supabase = Supabase.instance.client;

  Future<String> uploadAvatar(File file) async {
    try {
      var fileName = '${const Uuid().v4()}.png';

      final response = await supabase.storage
          .from('avatars') // Replace with your storage bucket name
          .upload(fileName, file);

      return response;
    } catch (error) {
      _logger.e('uploadAvatar', 'Error uploading avatar: $error');
      rethrow;
    }
  }

  String getAvatarUrl(String avatarImagePath) {
    var fileName = avatarImagePath.replaceAll('avatars/', '');
    var url = supabase.storage.from('avatars').getPublicUrl(fileName);
    return url;
  }
}