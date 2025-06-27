import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/ui/router.dart';

class AppTopBar extends HookConsumerWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    this.canPop,
    this.actions,
    this.color,
    this.titleLeftPadding = 20,
    required this.title,
  }) : assert(title != null && (title is String || title is Widget));
  final dynamic title;
  final bool? canPop;
  final List<Widget>? actions;
  final double titleLeftPadding;
  final Color? color;
  @override
  PreferredSizeWidget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final _canPop = canPop ?? router.canPop();
    final _title = title is String
        ? Text(
            title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          )
        : title;
    (actions)?.add(const SizedBox(width: 8));
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      centerTitle: false,
      backgroundColor: color ?? colorScheme.surfaceContainer,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness:
            Theme.of(context).brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
      title: Padding(
        padding: EdgeInsets.only(left: _canPop ? 8 : titleLeftPadding),
        child: _title,
      ),
      leading: _canPop
          ? IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                backgroundColor: WidgetStateProperty.all(
                  colorScheme.inverseSurface.withAlpha(20),
                ),
                minimumSize: WidgetStateProperty.all(const Size(36, 36)),
              ),
              icon: const Icon(CupertinoIcons.back, size: 22),
              onPressed: () {
                context.pop();
              },
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
