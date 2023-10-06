import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TapCard extends StatefulHookConsumerWidget {
  const TapCard(
      {super.key,
      this.margin,
      this.backgroundColor,
      this.titleColor,
      this.subTitleColor,
      required this.onTap,
      required this.title,
      required this.subtitle,
      required this.trailing});

  final EdgeInsets? margin;
  final String title;
  final String subtitle;
  final Widget trailing;
  final Function() onTap;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TapCardState();
}

class _TapCardState extends ConsumerState<TapCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: widget.margin ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ListTile(
          onTap: widget.onTap,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.title,
              style: TextStyle(
                  color: widget.titleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          subtitle: Text(
            widget.subtitle,
            style: TextStyle(
                color: widget.subTitleColor ??
                    Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                fontSize: 13),
          ),
          trailing: widget.trailing,
          tileColor: widget.backgroundColor ??
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }
}
