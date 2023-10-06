import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/reader/reader_provider.dart';

class MenuBottom extends StatefulHookConsumerWidget {
  const MenuBottom({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuBottomState();
}

class _MenuBottomState extends ConsumerState<MenuBottom>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(readerMenuStateProvider);
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return AnimatedPositioned(
      bottom: state.menuBottomVisible ? 0 : -100,
      left: 0,
      duration: const Duration(milliseconds: 200),
      child: Container(
          height: 42 + bottomPadding,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: bottomPadding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Wrap(
            children: [
              Row(children: [
                Flexible(
                    child: Center(
                  child: IconButton(
                      onPressed: () {
                        ref.read(readerMenuStateProvider.notifier).dispatch(
                            menuTopVisible: ref
                                .read(readerMenuStateProvider)
                                .menuCatalogVisible,
                            menuCatalogVisible: !ref
                                .read(readerMenuStateProvider)
                                .menuCatalogVisible,
                            menuThemeVisible: false,
                            menuTextVisible: false,
                            menuConfigVisible: false);
                        // ref
                        //     .read(readerMenuStateProvider.notifier)
                        //     .toggleBottomAndTop();
                      },
                      icon: SvgPicture.asset(
                          "assets/svg/ic_bottom_bar_menu.svg",
                          width: 18,
                          colorFilter: ColorFilter.mode(
                              state.menuCatalogVisible
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onBackground,
                              BlendMode.srcIn))),
                )),
                Flexible(
                    child: Center(
                  child: IconButton(
                      onPressed: () {
                        ref.read(readerMenuStateProvider.notifier).dispatch(
                            menuTopVisible: ref
                                .read(readerMenuStateProvider)
                                .menuThemeVisible,
                            menuCatalogVisible: false,
                            menuThemeVisible: !ref
                                .read(readerMenuStateProvider)
                                .menuThemeVisible,
                            menuTextVisible: false,
                            menuConfigVisible: false);
                      },
                      icon: SvgPicture.asset(
                          "assets/svg/ic_bottom_bar_palette.svg",
                          width: 18,
                          colorFilter: ColorFilter.mode(
                              state.menuThemeVisible
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onBackground,
                              BlendMode.srcIn))),
                )),
                Flexible(
                    child: Center(
                  child: IconButton(
                      onPressed: () {
                        ref.read(readerMenuStateProvider.notifier).dispatch(
                            menuTopVisible: ref
                                .read(readerMenuStateProvider)
                                .menuTextVisible,
                            menuCatalogVisible: false,
                            menuThemeVisible: false,
                            menuTextVisible: !ref
                                .read(readerMenuStateProvider)
                                .menuTextVisible,
                            menuConfigVisible: false);
                      },
                      icon: SvgPicture.asset(
                          "assets/svg/ic_bottom_bar_font.svg",
                          width: 18,
                          colorFilter: ColorFilter.mode(
                              state.menuTextVisible
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onBackground,
                              BlendMode.srcIn))),
                )),
                Flexible(
                    child: Center(
                  child: IconButton(
                      onPressed: () {
                        ref.read(readerMenuStateProvider.notifier).dispatch(
                            menuTopVisible: ref
                                .read(readerMenuStateProvider)
                                .menuConfigVisible,
                            menuCatalogVisible: false,
                            menuThemeVisible: false,
                            menuTextVisible: false,
                            menuConfigVisible: !ref
                                .read(readerMenuStateProvider)
                                .menuConfigVisible);
                      },
                      icon: SvgPicture.asset(
                          "assets/svg/ic_bottom_bar_setting.svg",
                          width: 18,
                          colorFilter: ColorFilter.mode(
                              state.menuConfigVisible
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onBackground,
                              BlendMode.srcIn))),
                )),
              ])
            ],
          )),
    );
  }
}
