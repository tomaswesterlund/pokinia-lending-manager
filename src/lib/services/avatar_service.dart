import 'dart:io';

import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/models/data/client.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class AvatarService {
  final Logger _logger = getLogger('AvatarService');
  final supabase = Supabase.instance.client;

  Future<String> uploadAvatar(File file) async {
    try {
      var fileName = '${const Uuid().v4()}.png';

      final response = await supabase.storage
          .from('avatars') // Replace with your storage bucket name
          .upload(fileName, file);

      return response;
    } catch (error) {
      _logger.e('Error uploading avatar: $error');
      rethrow;
    }
  }

  String getAvatarUrl(Client client) {
    var fileName = client.avatarImagePath!.replaceAll('avatars/', '');
    var url = supabase.storage.from('avatars').getPublicUrl(fileName);
    return url;
  }
}