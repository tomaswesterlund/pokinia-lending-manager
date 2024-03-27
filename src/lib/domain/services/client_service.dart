import 'package:pokinia_lending_manager/core/models/response.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/domain/repositories/client_repository.dart';

class ClientService {
  final ClientRepository _clientRepository;

  ClientService(this._clientRepository);

  List<ClientEntity> getAllClients() {
    var data = _clientRepository.getAllClients();
    return data.map((e) => ClientEntity.fromDataModel(e)).toList();
  }

  ClientEntity getClientById(String id) {
    var data = _clientRepository.getClientById(id);
    return ClientEntity.fromDataModel(data);
  }

  Future<Response> createClient(
      {required String organizationId,
      required String name,
      String? phoneNumber,
      String? address,
      String? avatarImagePath}) async {
    return await _clientRepository.createClient(
      organizationId: organizationId,
      name: name,
      phoneNumber: phoneNumber,
      address: address,
      avatarImagePath: avatarImagePath,
    );
  }

  Future<Response> deleteClient(String id, String deleteReason) async {
    return await _clientRepository.deleteClient(id, deleteReason);
  }

  Future<Response> undeleteClient(String id) async {
    return await _clientRepository.undeleteClient(id);
  }

  void addListener(Function() listener) {
    _clientRepository.addListener(listener);
  }
}
