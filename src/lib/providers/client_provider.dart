import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';
import 'package:pokinia_lending_manager/models/loan_model.dart';
import 'package:pokinia_lending_manager/models/payment_model.dart';

class ClientProvider extends ChangeNotifier {
  late final List<ClientModel> _clients;

  ClientProvider() {
    // Client one
    var clientOne =
        ClientModel(name: "Client One", phoneNumber: '+52 55 1234 9999');

    var clientOneLoanOne = LoanModel(amount: 1000, interestRate: 5.0);
    clientOneLoanOne.addScheduledPayment(PaymentModel(
        amount: 50,
        interestRate: 5.0,
        payDate: DateTime.now().add(const Duration(days: 7)))); // Prompt
    clientOne.addLoan(clientOneLoanOne);

    // Client two
    var clientTwo =
        ClientModel(name: "Client Two", phoneNumber: '+52 55 1234 9999');

    var clientTwoLoanOne = LoanModel(amount: 5000, interestRate: 2.5);
    clientTwoLoanOne.addScheduledPayment(PaymentModel(
        amount: 125,
        interestRate: 2.5,
        payDate: DateTime.now().add(const Duration(days: -7)))); // Overdue
    clientTwo.addLoan(clientTwoLoanOne);

    // Client three
    var clientThree =
        ClientModel(name: "Client Three", phoneNumber: '+52 55 1234 9999');

    var clientThreeLoanOne = LoanModel(amount: 9999, interestRate: 1.5);
    clientThreeLoanOne.addScheduledPayment(PaymentModel(
        amount: 150,
        interestRate: 1.5,
        payDate: DateTime.now().add(const Duration(days: -2)))); // Warning
    clientThree.addLoan(clientThreeLoanOne);

    // Client four
    var clientFour =
        ClientModel(name: "Client four", phoneNumber: '+52 55 1234 9999');
    // No loan

    _clients = [clientOne, clientTwo, clientThree, clientFour];
    
  }

  List<ClientModel> get clients => _clients;
  bool get hasClients => _clients.isNotEmpty;

  void addClient(String name, String phoneNumber, String? address) {
    ClientModel client = ClientModel(name: name, phoneNumber: phoneNumber);
    _clients.add(client);
    notifyListeners();
  }

  void removeClient(ClientModel client) {
    _clients.remove(client);
    notifyListeners();
  }

  ClientModel? getLatestClientBasedOnName(String name) {
    return _clients.where((client) => client.name == name).toList().first;
  }
}
