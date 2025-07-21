import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/reader/services/provider.dart';

class MenuBottom extends HookConsumerWidget {
  final bool isVisible;
  final Widget? child;
  final double height;

  const MenuBottom({
    super.key,
    this.isVisible = false,
    this.child,
    this.height = 64, // 默认高度
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 使用 hooks 监听 isVisible 变化
    // final isVisibleState = useState(isVisible);
    final state = ref.watch(ReaderProviderService().menuProvider_);

    // 当属性变化时更新状态
    // useEffect(() {
    //   isVisibleState.value = isVisible;
    //   return null;
    // }, [isVisible]);

    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          bottom: state.bottom ? 0 : -height - bottomPadding,
          left: 0,
          right: 0,
          height: height + bottomPadding,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: bottomPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(40),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Flexible(
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        // ref.read(ReaderProviderService().menuProvider_.notifier).dispatch(
                        //     menuTopVisible: ref
                        //         .read(readerMenuStateProvider)
                        //         .menuCatalogVisible,
                        //     menuCatalogVisible: !ref
                        //         .read(readerMenuStateProvider)
                        //         .menuCatalogVisible,
                        //     menuThemeVisible: false,
                        //     menuTextVisible: false,
                        //     menuConfigVisible: false);
                        // ref
                        //     .read(readerMenuStateProvider.notifier)
                        //     .toggleBottomAndTop();
                      },
                      icon: SvgPicture.asset(
                        "assets/svg/ic_bottom_bar_menu.svg",
                        width: 18,
                        colorFilter: ColorFilter.mode(
                          state.catalog
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        // ref
                        //     .read(readerMenuStateProvider.notifier)
                        //     .dispatch(
                        //       menuTopVisible: ref
                        //           .read(readerMenuStateProvider)
                        //           .menuThemeVisible,
                        //       menuCatalogVisible: false,
                        //       menuThemeVisible: !ref
                        //           .read(readerMenuStateProvider)
                        //           .menuThemeVisible,
                        //       menuTextVisible: false,
                        //       menuConfigVisible: false,
                        //     );
                      },
                      icon: SvgPicture.asset(
                        "assets/svg/ic_bottom_bar_palette.svg",
                        width: 18,
                        colorFilter: ColorFilter.mode(
                          state.theme
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onBackground,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        // ref
                        //     .read(readerMenuStateProvider.notifier)
                        //     .dispatch(
                        //       menuTopVisible: ref
                        //           .read(readerMenuStateProvider)
                        //           .menuTextVisible,
                        //       menuCatalogVisible: false,
                        //       menuThemeVisible: false,
                        //       menuTextVisible: !ref
                        //           .read(readerMenuStateProvider)
                        //           .menuTextVisible,
                        //       menuConfigVisible: false,
                        //     );
                      },
                      icon: SvgPicture.asset(
                        "assets/svg/ic_bottom_bar_font.svg",
                        width: 18,
                        colorFilter: ColorFilter.mode(
                          state.typography
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onBackground,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        // ref
                        //     .read(readerMenuStateProvider.notifier)
                        //     .dispatch(
                        //       menuTopVisible: ref
                        //           .read(readerMenuStateProvider)
                        //           .menuConfigVisible,
                        //       menuCatalogVisible: false,
                        //       menuThemeVisible: false,
                        //       menuTextVisible: false,
                        //       menuConfigVisible: !ref
                        //           .read(readerMenuStateProvider)
                        //           .menuConfigVisible,
                        //     );
                      },
                      icon: SvgPicture.asset(
                        "assets/svg/ic_bottom_bar_setting.svg",
                        width: 18,
                        colorFilter: ColorFilter.mode(
                          state.config
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
