import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/providers/user.dart';

class Avatar extends StatefulHookConsumerWidget {
  const Avatar({super.key, this.size = 32});
  final double size;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarState();
}

class _AvatarState extends ConsumerState<Avatar> {
  @override
  Widget build(BuildContext context) {
    final avatarData = ref.watch(userAvatarProvider);
    final defaultAvatar = Image.asset(
      "assets/img/akari.jpg",
      fit: BoxFit.cover,
      width: widget.size,
      height: widget.size,
    );
    return Container(
      width: widget.size,
      height: widget.size,
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size / 2),
        child: switch (avatarData) {
          AsyncData(:final value) => Image.memory(
            value,
            fit: BoxFit.cover,
            width: widget.size,
            height: widget.size,
            errorBuilder: (_, __, ___) => defaultAvatar,
          ),
          _ => defaultAvatar,
        },
      ),
    );
  }
}
