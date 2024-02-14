import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:pokinia_lending_manager/models/client_model.dart';

class MyAvatarComponent extends StatelessWidget {
  final ClientModel client;
  final double size;
  const MyAvatarComponent({super.key, required this.client, this.size = 48.0});

  @override
  Widget build(BuildContext context) {
    return client.avatarImagePath != null
        ? AdvancedAvatar(size: size, image: NetworkImage(client.avatarImagePath!))
        : AdvancedAvatar(
            name: client.name,
            size: size,
          );
  }
}
