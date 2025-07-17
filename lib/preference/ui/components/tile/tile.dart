import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PreferenceTile extends StatefulHookConsumerWidget {
  const PreferenceTile({
    super.key,
    required this.title,
    this.description,
    this.trailing,
    this.leading,
    this.onTap,
  });
  final String title;
  final String? description;
  final Widget? trailing;
  final Widget? leading;
  final Function()? onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PreferenceTileState();
}

class _PreferenceTileState extends ConsumerState<PreferenceTile> {
  @override
  Widget build(BuildContext context) {
    // final task = useFuture(Future.microtask(widget.onTap ?? () {}));
    final loading = useState(false);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      subtitle: widget.description != null
          ? Padding(
              padding: EdgeInsets.only(top: 0),
              child: Text(
                "跟随系统",
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(140),
                ),
              ),
            )
          : null,
      trailing: Padding(
        padding: EdgeInsets.only(right: 4),
        child: loading.value
            ? CupertinoActivityIndicator(
                radius: 10,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(140),
              )
            : widget.trailing ??
                  SvgPicture.asset(
                    "assets/svg/ic_chevron_right.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSurface.withAlpha(140),
                      BlendMode.srcIn,
                    ),
                    width: 10,
                  ),
      ),
      onTap: () {
        if (loading.value) {
          return;
        }
        if (widget.onTap == null) {
          return;
        }
        if (widget.onTap is Future Function()) {
          loading.value = true;
          Future.wait([
            Future.delayed(Duration(milliseconds: 500), widget.onTap),
          ]).whenComplete(() => loading.value = false);
        } else {
          widget.onTap?.call();
        }
      },
    );
  }
}
