import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/data/models/client_data_model.dart';
import 'package:pokinia_lending_manager/data/repositories/base_repository.dart';
import 'package:pokinia_lending_manager/domain/repositories/client_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientRepository extends BaseRepository<ClientDataModel>
    with ClientRepository {
  SupabaseClientRepository(SupabaseClient supabaseClient)
      : super(supabaseClient, DataRepositories.clientRepository,
            TableNames.clients, (data) => ClientDataModel.fromJson(data));

  @override
  List<ClientDataModel> getAllClients() {
    return data;
  }

  @override
  ClientDataModel getClientById(String id) {
    return data.firstWhere((element) => element.id == id);
  }

  @override
  Future<Response> createClient(
      {required String organizationId,
      required String name,
      String? phoneNumber,
      String? address,
      String? avatarImagePath}) async {
    try {
      var params = {
        'v_organization_id': organizationId,
        'v_name': name,
        'v_phone_number': phoneNumber,
        'v_address': address,
        'v_avatar_image_path': avatarImagePath ?? ''
      };

      await supabaseClient.rpc('create_client', params: params);

      return Response.successWithMessage(message: 'Client created successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> deleteClient(String id, String deleteReason) async {
    // TODO: implement deleteClient

    try {
      var params = {
        'v_client_id': id,
        'v_delete_date': DateTime.now().toIso8601String(),
        'v_delete_reason': deleteReason,
      };

      await supabaseClient.rpc('delete_client', params: params);

      return Response.successWithMessage(message: 'Client deleted successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }

  @override
  Future<Response> undeleteClient(String id) async {
    try {
      var params = {'v_client_id': id};

      await supabaseClient.rpc('undelete_client', params: params);

      return Response.successWithMessage(message: 'Client undeleted successfully');
    } catch (e) {
      return Response.errorWithMessage(message: e.toString());
    }
  }
}
