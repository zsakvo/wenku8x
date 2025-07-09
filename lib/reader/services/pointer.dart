import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/ui/router.dart';
import 'package:wenku8x/reader/providers/menu_visible.dart';

class PointerService {
  static final PointerService _instance = PointerService._internal();

  factory PointerService() {
    return _instance;
  }

  PointerService._internal();

  // final screenHeight = rootNavigatorKey.currentContext!.size!.height;
  // final screenWidth = rootNavigatorKey.currentContext!.size!.width;

  late WidgetRef ref;
  late BuildContext context;
  double pointerDownPosX = 0.0;

  init(WidgetRef widgetRef, BuildContext context) {
    ref = widgetRef;
    this.context = context;
  }

  void onPointerDown(PointerDownEvent event) {
    pointerDownPosX = event.position.dx;
    // pointDownPage = pageController.page!.round();
  }

  void onPointerMove(PointerMoveEvent event) {
    final menuVisible = ref.read(menuProvider);
    // Handle pointer move events
    if (menuVisible.sub) {
      return;
    }
    if (menuVisible.parent) {
      return;
    }
    // // 当移动距离 posX 大于 5 个像素的时候开始跟随
    final dx = event.position.dx - pointerDownPosX;
    // if (dx.abs() > 5) {
    //   // 最后一章和第一章禁止额外滚动
    //   double offset = pageController.offset - event.delta.dx;
    //   if (offset <= 0) {
    //     offset = 0;
    //   } else {
    //     offset = offset > pageController.position.maxScrollExtent
    //         ? pageController.position.maxScrollExtent
    //         : offset;
    //   }
    //   pageController.jumpTo(offset);
    // }
  }

  void onPointerUp(PointerUpEvent event) {
    final menuVisible = ref.read(menuProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // 如果子菜单开启，则不响应翻页 只关闭子菜单
    if (menuVisible.sub) {
      ref
          .read(menuProvider.notifier)
          .dispatch(
            menuCatalogVisible: false,
            menuThemeVisible: false,
            menuTextVisible: false,
            menuConfigVisible: false,
            menuTopVisible: true,
            menuBottomVisible: true,
          );
      return;
    }
    // // 如果父菜单开启，则不响应翻页，只关闭父菜单
    if (menuVisible.parent) {
      ref.read(menuProvider.notifier).reset();
      return;
    }
    final dx = event.position.dx;
    final dy = event.position.dy;
    final deltaX = dx - pointerDownPosX;
    // // Log.e(dx);
    // // 检测 dx 绝对值
    if (deltaX.abs() < 5) {
      // 如果开启了子菜单，则隐藏子菜单
      if (ref.read(menuProvider).sub) {
        ref
            .read(menuProvider.notifier)
            .dispatch(
              menuCatalogVisible: false,
              menuThemeVisible: false,
              menuTextVisible: false,
              menuConfigVisible: false,
              menuTopVisible: true,
              menuBottomVisible: true,
            );
        return;
      } else {
        if (menuVisible.bottom) {
          // ref.read(readerMenuStateProvider.notifier).toggleBottomAndTop();
          ref.read(menuProvider.notifier).toggleParent();
        } else {
          // 仅在屏幕中央 1/3 的区域内点击才会触发菜单栏
          if ((dy > screenHeight / 3 && dy < screenHeight / 3 * 2) &&
              (dx > screenWidth / 3 && dx < screenWidth / 3 * 2)) {
            // ref.read(readerMenuStateProvider.notifier).toggleBottomAndTop();
            ref.read(menuProvider.notifier).toggleParent();
          }
          // 如果点击屏幕右侧 1/3 则翻到下一页
          else if (dx > screenWidth / 3 * 2) {
            // if (_checkLastPage()) return;
            // pageController.nextPage(
            //   duration: const Duration(milliseconds: 240),
            //   curve: Curves.easeInOut,
            // );
          }
          // 如果点击左侧 1/3 翻到上一页
          else if (dx < screenWidth / 3) {
            // if (_checkFirstPage()) return;
            // pageController.previousPage(
            //   duration: const Duration(milliseconds: 240),
            //   curve: Curves.easeInOut,
            // );
          }
        }
      }
    } else {
      // if (deltaX < -10) {
      //   if (_checkLastPage()) return;
      //   pageController.animateToPage(
      //     pointDownPage + 1,
      //     duration: const Duration(milliseconds: 240),
      //     curve: Curves.easeInOut,
      //   );
      // } else if (deltaX > 10) {
      //   if (_checkFirstPage()) return;
      //   pageController.animateToPage(
      //     pointDownPage - 1,
      //     duration: const Duration(milliseconds: 240),
      //     curve: Curves.easeInOut,
      //   );
      // } else {
      //   pageController.animateToPage(
      //     pointDownPage,
      //     duration: const Duration(milliseconds: 240),
      //     curve: Curves.easeInOut,
      //   );
      // }
    }
  }
}
