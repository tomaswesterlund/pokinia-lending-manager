import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/domain/entities/client_entity.dart';
import 'package:pokinia_lending_manager/presentation/widgets/shared/deleted_alert_box.dart';

final class ClientDeletedBox extends StatelessWidget {
  final ClientEntity client;
  const ClientDeletedBox({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return client.deleted == true
        ? DeletedAlertBox(
            title: 'Client has been deleted!',
            deleteDate: client.deleteDate,
            deleteReason: client.deleteReason)
        : const SizedBox.shrink();
  }
}
