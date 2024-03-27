import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/data/models/client_data_model.dart';

mixin ClientRepository {
  addListener(Function() onChangesNotifyListeners);

  List<ClientDataModel> getAllClients();

  ClientDataModel getClientById(String id);

  Future<Response> deleteClient(String id, String deleteReason);

  Future<Response> undeleteClient(String id);

  Future<Response> createClient(
      {required String organizationId,
      required String name,
      String? phoneNumber,
      String? address,
      String? avatarImagePath});
}
