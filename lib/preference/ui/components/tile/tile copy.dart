import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PreferenceTile extends StatefulHookConsumerWidget {
  const PreferenceTile({super.key, required this.title});
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PreferenceTileState();
}

class _PreferenceTileState extends ConsumerState<PreferenceTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      title: Text(widget.title),
      trailing: SvgPicture.asset(
        "assets/svg/ic_chevron_right.svg",
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
        ),
        width: 13,
      ),
    );
  }
}
