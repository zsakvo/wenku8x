import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNav extends ConsumerWidget {
  const BottomNav(this.navigationShell, {super.key, required this.items});

  final StatefulNavigationShell navigationShell;
  final List<BottomBarItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.secondary.withAlpha(200),
        selectedLabelStyle: TextStyle(fontSize: 10),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        onTap: (value) {
          navigationShell.goBranch(
            value,
            initialLocation: value == navigationShell.currentIndex,
          );
        },
        items: items.mapIndexed((index, item) {
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "${item.svgPath}.svg",
              colorFilter: ColorFilter.mode(
                navigationShell.currentIndex == index
                    ? colorScheme.primary
                    : colorScheme.secondary.withAlpha(200),
                BlendMode.srcIn,
              ),
              width: 22,
            ),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}

class BottomBarItem {
  final String svgPath;
  final String label;
  const BottomBarItem({required this.svgPath, required this.label});
}
