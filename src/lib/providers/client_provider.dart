// import 'package:flutter/material.dart';
// import 'package:pokinia_lending_manager/enums/client_payment_status.dart';
// import 'package:pokinia_lending_manager/enums/loan_payment_status.dart';
// import 'package:pokinia_lending_manager/models/client_model.dart';
// import 'package:pokinia_lending_manager/providers/loan_provider.dart';
// import 'package:pokinia_lending_manager/services/loan_service.dart';

// class ClientProvider extends ChangeNotifier {

//   final LoanProvider loanProvider;

//   ClientProvider({required this.loanProvider});

//   Stream<List<ClientModel>> get clientStream =>
//       databaseService.getClientsStream();

//   ClientPaymentStatus getClientPaymentStatus(String clientId) {
//     var loans = databaseService.getLoansByClientId(clientId);

//     if (loans.isEmpty) {
//       return ClientPaymentStatus.empty;
//     } else {
//       if (loans.any((loan) =>
//           loanProvider.getLoanPaymentStatus(loan.id) ==
//           LoanPaymentStatus.overdue)) {
//         return ClientPaymentStatus.overdue;
//       } else {
//         return ClientPaymentStatus.prompt;
//       }
//     }
//   }

//   void addClient(
//       {required String id,
//       required String name,
//       required String phoneNumber,
//       String? address}) {
//     ClientModel client =
//         ClientModel(id: id, name: name, phoneNumber: phoneNumber);
//     //_clients.add(client);
//     notifyListeners();
//   }

//   void removeClient(ClientModel client) {
//     //_clients.remove(client);
//     notifyListeners();
//   }

//   ClientModel? getLatestClientBasedOnName(String name) {
//     return ClientModel(id: '-1', name: '-1', phoneNumber: '-1');

//     // return _clients.where((client) => client.name == name).toList().first;
//   }

//   ClientModel getClientById(String id) {
//     return ClientModel(id: '-1', name: '-1', phoneNumber: '-1');
//     //return _clients.where((client) => client.id == id).toList().first;
//   }
// }
