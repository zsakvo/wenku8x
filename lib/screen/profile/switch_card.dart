import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SwitchCard extends StatefulHookConsumerWidget {
  const SwitchCard(
      {super.key,
      this.margin,
      required this.title,
      required this.subtitle,
      required this.value,
      required this.onChanged});

  final EdgeInsets? margin;
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool value) onChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SwitchCardState();
}

class _SwitchCardState extends ConsumerState<SwitchCard> {
  @override
  Widget build(BuildContext context) {
    final switchWidth = Platform.isMacOS ? 42.0 : 48.0;
    final switchHeight = Platform.isMacOS ? 28.0 : 36.0;
    final value = useState(widget.value);
    return Container(
        margin: widget.margin ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
          subtitle: Text(
            widget.subtitle,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                fontSize: 13),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SizedBox(
                width: switchWidth,
                height: switchHeight,
                child: FittedBox(
                    fit: BoxFit.fill,
                    child: Switch(
                        value: value.value,
                        onChanged: (val) {
                          value.value = val;
                          widget.onChanged(val);
                        }))),
          ),
          tileColor:
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }
}
