import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/providers/client_provider.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:pokinia_lending_manager/services/toast_service.dart';
import 'package:provider/provider.dart';

class ClientAppBar extends StatelessWidget {
  final Logger _logger = getLogger('LoanAppBar');
  final String clientId;
  final String title;
  final bool isDeleted;

  ClientAppBar(
      {super.key,
      required this.clientId,
      required this.title,
      required this.isDeleted});

  void _onMenuItemClicked(BuildContext context, int index) async {
    if (index == 2) {
      _deleteClient(context);
    }

    if (index == 3) {
      _undeleteClient(context);
    }
  }

  void _deleteClient(BuildContext context) {
    _logger.i('_deleteClient - id: $clientId');

    var clientService = Provider.of<ClientProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete client'),
          content: const Text('Are you sure you want to delete this client?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Add your deletion logic here
                var response = await clientService.deleteClient(
                    clientId, 'Deleted by user from client page');

                if (response.succeeded) {
                  Navigator.of(context).pop();
                } else {
                  ToastService().showErrorToast(response.message);
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _undeleteClient(BuildContext context) {
    _logger.i('_undeleteClient - id: $clientId');

    var clientService = Provider.of<ClientProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Undelete client'),
          content: const Text('Are you sure you want to undelete this client?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Add your deletion logic here
                var response = await clientService.undeleteClient(clientId);

                if (response.succeeded) {
                  Navigator.pop(context);
                } else {
                  ToastService().showErrorToast(response.message);
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    if (isDeleted) {
      return _getAppBarWhenLClientIsDeleted(context);
    } else {
      return _getAppBarWhenClientIsNotDeleted(context);
    }
  }

  Widget _getAppBarWhenClientIsNotDeleted(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
      actions: [
        PopupMenuButton<int>(
          onSelected: (value) => _onMenuItemClicked(context, value),
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 1,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 12.0),
                      Text(
                        "Edit client",
                      )
                    ],
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<int>(
              value: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        "Delete client",
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _getAppBarWhenLClientIsDeleted(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
      actions: [
        PopupMenuButton<int>(
          onSelected: (value) => _onMenuItemClicked(context, value),
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 3,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.undo,
                        color: Colors.red,
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        "Un-delete client",
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
