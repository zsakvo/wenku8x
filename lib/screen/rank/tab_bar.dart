import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RankTabBar extends HookConsumerWidget implements PreferredSizeWidget {
  const RankTabBar({super.key, this.selectedIndex = 0, required this.tabs, required this.onTabChange});
  final int selectedIndex;
  final List<Map<String, dynamic>> tabs;
  final Function(String flag) onTabChange;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ButtonStyle buttonStyle = FilledButton.styleFrom(
        minimumSize: const Size(72, 30),
        textStyle: const TextStyle(fontSize: 13),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tabs
            .asMap()
            .map((index, e) {
              return MapEntry(
                  index,
                  index == selectedIndex
                      ? FilledButton(
                          onPressed: () {
                            onTabChange(e["flag"]);
                          },
                          style: buttonStyle,
                          child: Text(e["title"]),
                        )
                      : FilledButton.tonal(
                          onPressed: () {
                            onTabChange(e["flag"]);
                          },
                          style: buttonStyle.copyWith(
                              backgroundColor: MaterialStateProperty.all(Colors.transparent),
                              side:
                                  MaterialStateProperty.all(BorderSide(color: Theme.of(context).colorScheme.primary))),
                          // side: MaterialStateProperty.all(BorderSide(color: Colors.transparent))),
                          child: Text(e["title"]),
                        ));
            })
            .values
            .toList(),
        // children: [
        //   FilledButton(
        //     onPressed: () {},
        //     style: buttonStyle,
        //     child: Text("总榜"),
        //   ),
        //   FilledButton.tonal(
        //     onPressed: () {},
        //     style: buttonStyle,
        //     child: Text("月榜"),
        //   ),
        //   FilledButton.tonal(
        //     onPressed: () {},
        //     style: buttonStyle,
        //     child: Text("周榜"),
        //   ),
        //   FilledButton.tonal(
        //     onPressed: () {},
        //     style: buttonStyle,
        //     child: Text("日榜"),
        //   )
        // ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(42);
}
