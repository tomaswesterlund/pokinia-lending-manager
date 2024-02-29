import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/models/client.dart';
import 'package:pokinia_lending_manager/services/avatar_service.dart';
import 'package:pokinia_lending_manager/util/string_extensions.dart';

class MyAvatarComponent extends StatelessWidget {
  final Client client;
  final double size;
  final double strokeWidth;

  const MyAvatarComponent(
      {super.key,
      required this.client,
      this.size = 48.0,
      this.strokeWidth = 1.0});

  @override
  Widget build(BuildContext context) {
    
    return client.avatarImagePath.isNotNullOrEmpty()
        ? CircularProfileAvatar(
            AvatarService().getAvatarUrl(client),
            borderColor: const Color(0xFF008080),
            borderWidth: strokeWidth,
            elevation: 0,
            radius: size / 2,
          )
        : CircularProfileAvatar(
            '',
            borderColor: const Color(0xFF008080),
            backgroundColor: const Color(0xFFEBF2F2),
            borderWidth: strokeWidth,
            elevation: 0,
            radius: size / 2,
            child: Center(
              child: Text(
                client.name.getInitials().toUpperCase(),
              ),
            ),
          );
  }
}
