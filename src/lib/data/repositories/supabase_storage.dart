import 'dart:io';

import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/domain/repositories/storage_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorage implements StorageRepository {
  final SupabaseClient _supabaseClient;

  SupabaseStorage(this._supabaseClient);

  @override
  Future<String> uploadFileAndReturnUrl(
      String bucketName, String fileName, File file) async {
    try {
      var response = await uploadFile(bucketName, fileName, file);
      var url = getPublicUrl(bucketName, fileName);
      return url;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> uploadFile(
      String bucketName, String fileName, File file) async {
    try {
      final response =
          await _supabaseClient.storage.from(bucketName).upload(fileName, file);

      return Response.successWithMessage(message: 'File uploaded successfully');
    } catch (error) {
      return Response.errorWithMessage(message: error.toString());
    }
  }

  @override
  String getPublicUrl(String bucketName, String fileName) {
    try {
      return _supabaseClient.storage.from(bucketName).getPublicUrl(fileName);
    } catch (error) {
      rethrow;
    }
  }
}
