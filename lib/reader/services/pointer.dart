import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/ui/router.dart';
import 'package:wenku8x/reader/providers/menu_visible.dart';
import 'package:wenku8x/reader/services/provider.dart';
import 'package:wenku8x/reader/services/screen.dart';

class PointerService {
  static final logger = Logger("PointerService");
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
            menuBookmarkVisible: false,
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
              menuBookmarkVisible: false,
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

  // 手势检测区域配置
  static const double _menuTapWidth = 0.4; // 中间 40%区域用于菜单
  static const double _swipeAreaWidth = 0.3; // 左右 30%区域用于翻页
  double _dragStartX = 0;
  double _currentOffset = 0;
  bool _isDragging = false;

  onTapDown(TapDownDetails details) {
    // if (ReaderService().isAnimating) return;
    // final screenWidth = MediaQuery.of(context).size.width;
    // final tapX = details.globalPosition.dx;
    // final tapRatio = tapX / screenWidth;

    // logger.debug("Tap position: $tapX, Ratio: $tapRatio");

    // // 中央区域点击唤起菜单
    // if (tapRatio > _swipeAreaWidth && tapRatio < (1 - _swipeAreaWidth)) {
    //   // widget.onMenuTap?.call();
    //   ref.read(menuProvider.notifier).toggleParent();
    //   return;
    // }

    // // 左右区域点击翻页
    // if (tapRatio <= _swipeAreaWidth) {
    //   // _goToPreviousPage();
    // } else if (tapRatio >= (1 - _swipeAreaWidth)) {
    //   // _goToNextPage();
    // }
  }

  onTapUp(TapUpDetails details) {
    if (ReaderService().isAnimating) return;
    final screenWidth = MediaQuery.of(context).size.width;
    final tapX = details.globalPosition.dx;
    final tapRatio = tapX / screenWidth;

    logger.debug("Tap position: $tapX, Ratio: $tapRatio");

    // 中央区域点击唤起菜单
    if (tapRatio > _swipeAreaWidth && tapRatio < (1 - _swipeAreaWidth)) {
      // widget.onMenuTap?.call();
      ref.read(menuProvider.notifier).toggleParent();
      return;
    }

    // 左右区域点击翻页
    if (tapRatio <= _swipeAreaWidth) {
      // _goToPreviousPage();
      ReaderService().goToPreviousPage();
    } else if (tapRatio >= (1 - _swipeAreaWidth)) {
      // _goToNextPage();
      ReaderService().goToNextPage();
    }
  }

  onPanStart(DragStartDetails details) {
    if (ReaderService().isAnimating) return;

    _dragStartX = details.globalPosition.dx;
    _currentOffset = 0;
    _isDragging = true;

    // 触觉反馈
    HapticFeedback.selectionClick();
  }

  onPanUpdate(DragUpdateDetails details) {
    if (!_isDragging || ReaderService().isAnimating) return;
    final pageController = ReaderService().pageController;

    final deltaX = details.globalPosition.dx - _dragStartX;
    if (deltaX.abs() > 5) {
      double offset = pageController.offset - details.delta.dx;
      if (offset <= 0) {
        offset = 0;
      } else {
        offset = offset > pageController.position.maxScrollExtent
            ? pageController.position.maxScrollExtent
            : offset;
      }
      pageController.jumpTo(offset);
    }

    // // 限制拖拽范围，避免过度滚动
    // final maxOffset = screenWidth * 0.5;
    // _currentOffset = deltaX.clamp(-maxOffset, maxOffset);

    // // 实时更新页面位置
    // final targetPage =
    //     ReaderService().currentPage - (_currentOffset / screenWidth);
    // final pages = ref
    //     .read(ReaderProviderService().pagesProvider_)
    //     .asData
    //     ?.value;
    // if (pages == null) return;
    // ReaderService().pageController.animateToPage(
    //   targetPage.clamp(0, pages.pageCount - 1).toInt(),
    //   duration: Duration.zero,
    //   curve: Curves.linear,
    // );
  }

  onPanEnd(DragEndDetails details) {}
}
