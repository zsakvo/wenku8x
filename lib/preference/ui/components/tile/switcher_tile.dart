import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PreferenceSwitcherTile extends StatefulHookConsumerWidget {
  const PreferenceSwitcherTile({
    super.key,
    required this.title,
    required this.negativeDescription,
    required this.positiveDescription,
    required this.onChanged,
    this.value = false,
  });
  final bool value;
  final String title;
  final String negativeDescription;
  final String positiveDescription;
  final Function(bool value) onChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreferenceSwitcherTileState();
}

class _PreferenceSwitcherTileState
    extends ConsumerState<PreferenceSwitcherTile> {
  @override
  Widget build(BuildContext context) {
    final desc = widget.value
        ? widget.positiveDescription
        : widget.negativeDescription;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 0),
        child: Text(
          desc,
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(140),
          ),
        ),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(right: 0),
        child: Transform.scale(
          scale: .64,
          alignment: Alignment.centerRight,
          child: Switch(
            value: widget.value,
            onChanged: (value) {
              widget.onChanged(value);
            },
          ),
        ),
      ),
      onTap: () {
        widget.onChanged(!widget.value);
      },
    );
  }
}
