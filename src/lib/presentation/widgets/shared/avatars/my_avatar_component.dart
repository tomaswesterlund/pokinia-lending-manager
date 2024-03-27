import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/util/string_extensions.dart';
import 'package:pokinia_lending_manager/domain/services/avatar_service.dart';

class MyAvatarComponent extends StatelessWidget {
  final String name;
  final String? avatarImagePath;
  final double size;
  final double strokeWidth;

  const MyAvatarComponent(
      {super.key,
      required this.name,
      this.avatarImagePath,
      this.size = 48.0,
      this.strokeWidth = 1.0});

  @override
  Widget build(BuildContext context) {
    
    return avatarImagePath.isNotNullOrEmpty()
        ? CircularProfileAvatar(
            AvatarService().getAvatarUrl(avatarImagePath!),
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
                name.getInitials().toUpperCase(),
              ),
            ),
          );
  }
}
