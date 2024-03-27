import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/domain/services/client_service.dart';
import 'package:pokinia_lending_manager/view_models/base_view_model.dart';

class ClientListDropdownMenuViewModel extends BaseViewModel {
  final ClientService _clientService;

  ClientListDropdownMenuViewModel(this._clientService);

  ClientEntity? _selectedClient;
  ClientEntity? get selectedClient => _selectedClient;

  List<ClientEntity> getAllClients() {
    return _clientService.getAllClients();
  }
}
