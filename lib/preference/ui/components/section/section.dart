import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PreferenceSection extends StatefulHookConsumerWidget {
  const PreferenceSection({
    super.key,
    this.title,
    this.description,
    required this.children,
  });
  final String? title;
  final String? description;
  final List<Widget> children;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreferenceSectionState();
}

class _PreferenceSectionState extends ConsumerState<PreferenceSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title!.toUpperCase(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            margin: EdgeInsets.only(top: 6, bottom: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Column(children: widget.children),
          ),
        ),
        if (widget.description != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              widget.description!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
              ),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}
