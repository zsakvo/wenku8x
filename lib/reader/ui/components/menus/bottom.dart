import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/reader/services/provider.dart';

class MenuBottom extends StatefulHookConsumerWidget {
  const MenuBottom({
    super.key,
    this.isVisible = false,
    this.child,
    this.height = 52,
  });

  final bool isVisible;
  final Widget? child;
  final double height;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuBottomState();
}

class _MenuBottomState extends ConsumerState<MenuBottom> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ReaderProviderService().menuProvider_);
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: state.bottom ? 0 : -widget.height - bottomPadding,
      left: 0,
      right: 0,
      height: widget.height + bottomPadding,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 8, right: 8, bottom: bottomPadding),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        child: Wrap(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuButton(
                  label: "目录",
                  iconPath: "assets/svg/ic_menu_doc",
                  isActive: state.catalog,
                  onPressed: () {
                    // ref.read(readerMenusProvider.notifier).toggleSubMenu("directoryVisible");
                    ref
                        .read(ReaderProviderService().menuProvider_.notifier)
                        .toggleCatalog();
                  },
                ),
                _buildMenuButton(
                  label: "书签",
                  iconPath: "assets/svg/ic_menu_bookmark",
                  isActive: state.bookmark,
                  onPressed: () {
                    // ref.read(readerMenusProvider.notifier).toggleSubMenu("themeVisible");
                    ref
                        .read(ReaderProviderService().menuProvider_.notifier)
                        .toggleBookmark();
                  },
                ),
                _buildMenuButton(
                  label: "排版",
                  iconPath: "assets/svg/ic_menu_font",
                  isActive: state.typography,
                  onPressed: () {
                    // ref.read(readerMenusProvider.notifier).toggleSubMenu("fontVisible");
                  },
                ),
                _buildMenuButton(
                  label: "设置",
                  iconPath: "assets/svg/ic_menu_settings",
                  isActive: state.config,
                  onPressed: () {
                    // ref.read(readerMenusProvider.notifier).toggleSubMenu("settingVisible");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required String label,
    required String iconPath,
    required bool isActive,
    required Function() onPressed,
  }) {
    return
    // Flexible(
    //     child:
    Center(
      child: TextButton.icon(
        onPressed: onPressed,
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: WidgetStatePropertyAll(Size(84, 36)),
        ),
        label: Text(
          label,
          style: TextStyle(
            height: 1,
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.normal,
          ),
        ),
        icon: SvgPicture.asset(
          isActive ? "${iconPath}_fill.svg" : "$iconPath.svg",
          width: 20,
          colorFilter: ColorFilter.mode(
            isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            BlendMode.srcIn,
          ),
        ),
      ),
      // )
    );
  }
}

// class MenuBottom extends HookConsumerWidget {
//   final bool isVisible;
//   final Widget? child;
//   final double height;

//   const MenuBottom({
//     super.key,
//     this.isVisible = false,
//     this.child,
//     this.height = 64, // 默认高度
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // 使用 hooks 监听 isVisible 变化
//     // final isVisibleState = useState(isVisible);
//     final state = ref.watch(ReaderProviderService().menuProvider_);

//     final iconWidget = useCallback((String iconName, bool isActive) {
//       return SvgPicture.asset(
//         "assets/svg/$iconName.svg",
//         width: 24,
//         colorFilter: ColorFilter.mode(
//           isActive
//               ? Theme.of(context).colorScheme.primary
//               : Theme.of(context).colorScheme.onSurface,
//           BlendMode.srcIn,
//         ),
//       );
//     }, []);

//     // 当属性变化时更新状态
//     // useEffect(() {
//     //   isVisibleState.value = isVisible;
//     //   return null;
//     // }, [isVisible]);

//     final bottomPadding = MediaQuery.of(context).padding.bottom;

//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         AnimatedPositioned(
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//           bottom: state.bottom ? 0 : -height - bottomPadding,
//           left: 0,
//           right: 0,
//           height: height + bottomPadding,
//           child: Container(
//             width: double.infinity,
//             padding: EdgeInsets.only(bottom: bottomPadding, left: 8, right: 8),
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.surface,

//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withAlpha(40),
//                   blurRadius: 8,
//                   offset: const Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: Wrap(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildMenuButton(
//                       label: "目录",
//                       iconPath: "assets/svg/ic_menu_doc",
//                       isActive: state.catalog,
//                       onPressed: () {
//                         // ref.read(readerMenusProvider.notifier).toggleSubMenu("directoryVisible");
//                       },
//                     ),
//                     _buildMenuButton(
//                       label: "书签",
//                       iconPath: "assets/svg/ic_menu_bookmark",
//                       isActive: state.config,
//                       onPressed: () {
//                         // ref.read(readerMenusProvider.notifier).toggleSubMenu("themeVisible");
//                       },
//                     ),
//                     _buildMenuButton(
//                       label: "排版",
//                       iconPath: "assets/svg/ic_menu_font",
//                       isActive: state.typography,
//                       onPressed: () {
//                         // ref.read(readerMenusProvider.notifier).toggleSubMenu("fontVisible");
//                       },
//                     ),
//                     _buildMenuButton(
//                       label: "设置",
//                       iconPath: "assets/svg/ic_menu_settings",
//                       isActive: state.config,
//                       onPressed: () {
//                         // ref.read(readerMenusProvider.notifier).toggleSubMenu("settingVisible");
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//     Widget _buildMenuButton({
//     required String label,
//     required String iconPath,
//     required bool isActive,
//     required Function() onPressed,
//   }) {
//     return
//         // Flexible(
//         //     child:
//         Center(
//       child: TextButton.icon(
//           onPressed: onPressed,
//           style: const ButtonStyle(
//             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             minimumSize: WidgetStatePropertyAll(Size(84, 36)),
//           ),
//           label: Text(
//             label,
//             style: TextStyle(
//                 height: 1,
//                 color:
//                     isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
//                 fontWeight: FontWeight.normal),
//           ),
//           icon: SvgPicture.asset(
//             isActive ? "${iconPath}_fill.svg" : "$iconPath.svg",
//             width: 20,
//             colorFilter: ColorFilter.mode(
//                 isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
//                 BlendMode.srcIn),
//           )),
//       // )
//     );
//   }
// }
