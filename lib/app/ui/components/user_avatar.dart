import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/providers/user.dart';

class UserAvatar extends StatefulHookConsumerWidget {
  const UserAvatar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserAvatarState();
}

class _UserAvatarState extends ConsumerState<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    final avatarData = ref.watch(userAvatarProvider);
    return ClipOval(
      child: switch (avatarData) {
        AsyncData(:final value) => Image.memory(
          value,
          width: 32,
          height: 32,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 32),
        ),
        _ => Image.asset(
          "assets/img/akari.jpg",
          width: 32,
          height: 32,
          fit: BoxFit.cover,
        ),
      },
    );
  }
}
