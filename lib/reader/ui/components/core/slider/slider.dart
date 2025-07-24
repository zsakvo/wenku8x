import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/reader/helper/layout.dart';
import 'package:wenku8x/reader/services/provider.dart';

class SliderCore extends StatefulHookConsumerWidget {
  const SliderCore({
    super.key,
    required this.pages,
    required this.fetchNextChapter,
    this.onPageChanged,
  });

  final Map<int, PageLayout> pages;
  final Future<int> Function() fetchNextChapter;
  final void Function(int index)? onPageChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SliderCoreState();
}

class _SliderCoreState extends ConsumerState<SliderCore> {
  // 索引边界追踪
  int _minIndex = 0; // 最小索引（可能为负数）
  int _maxIndex = -1; // 最大索引
  int _centerIndex = 0; // 当前显示的中心索引

  // 状态标志
  bool _isLoadingPrev = false;
  bool _isLoadingNext = false;

  late final PageController pageController;
  bool isAnimating = false;
  static const double menuTapWidth = 0.4; // 中间 40%区域用于菜单
  static const double swipeAreaWidth = 0.3; // 左右 30%区域用于翻页
  double dragStartX = 0;
  double currentOffset = 0;
  bool isDragging = false;
  // int currentPage = 0;
  final Duration animationDuration = const Duration(milliseconds: 500);
  // 滑动方向是否单一
  bool singleDirection = true;
  // 滑动方向变更时的坐标（如果未变更过则为滑动结束位置）
  double turningPointX = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _minIndex = 0;
    _maxIndex = widget.pages.length - 1;
    // pageController.addListener(_onPageChanged);
  }

  _onTapUp(TapUpDetails details) {
    if (isAnimating) return;
    if (ref.read(ReaderProviderService().menuProvider_).sub) {
      ref
          .read(ReaderProviderService().menuProvider_.notifier)
          .forceTopAndBottom();
      return;
    }
    final screenWidth = MediaQuery.of(context).size.width;
    final tapX = details.globalPosition.dx;
    final tapRatio = tapX / screenWidth;

    logger.debug("Tap position: $tapX, Ratio: $tapRatio");

    // 中央区域点击唤起菜单
    if (tapRatio > swipeAreaWidth && tapRatio < (1 - swipeAreaWidth)) {
      // widget.onMenuTap?.call();
      ref.read(ReaderProviderService().menuProvider_.notifier).toggleParent();
      return;
    }

    // 左右区域点击翻页
    if (tapRatio <= swipeAreaWidth) {
      // _goToPreviousPage();
      _goToPreviousPage();
    } else if (tapRatio >= (1 - swipeAreaWidth)) {
      // _goToNextPage();
      _goToNextPage();
    }
  }

  _onPanStart(DragStartDetails details) {
    if (isAnimating) return;

    singleDirection = true; // 重置单一方向标志

    dragStartX = details.globalPosition.dx;
    currentOffset = 0;
    isDragging = true;

    // 触觉反馈
    // HapticFeedback.selectionClick();
  }

  _onPanUpdate(DragUpdateDetails details) {
    if (!isDragging || isAnimating) return;

    final deltaX = details.globalPosition.dx - dragStartX;
    if (deltaX.abs() > 5) {
      // 检测滑动方向变化
      final currentDirection = details.delta.dx > 0;
      if (currentOffset != 0) {
        final previousDirection = currentOffset > 0;
        if (currentDirection != previousDirection && singleDirection) {
          singleDirection = false;
          turningPointX = details.globalPosition.dx; // 更新转折点坐标
        }
      }

      double offset = pageController.offset - details.delta.dx;
      if (offset <= 0) {
        offset = 0;
      } else {
        offset = offset > pageController.position.maxScrollExtent
            ? pageController.position.maxScrollExtent
            : offset;
      }
      pageController.jumpTo(offset);

      currentOffset = deltaX;
    }
  }

  _onPanEnd(DragEndDetails details) {
    if (!isDragging || isAnimating) return;

    isDragging = false;

    final screenWidth = MediaQuery.of(context).size.width;
    final velocity = details.velocity.pixelsPerSecond.dx;
    final totalDragDistance =
        dragStartX - details.globalPosition.dx; // 正值表示向左滑，负值表示向右滑

    // 阈值设置
    const double distanceThreshold = 0.3; // 滑动距离超过屏幕宽度的30%
    const double velocityThreshold = 500.0; // 速度阈值

    // 计算当前页面的偏移比例
    final dragRatio = totalDragDistance / screenWidth;

    int targetPage = _centerIndex;

    if (totalDragDistance > 5) {
      // 向左滑动超过阈值，翻到下一页
      targetPage = (_centerIndex + 1).clamp(0, widget.pages.length - 1);
    } else if (totalDragDistance < -5) {
      // 向右滑动超过阈值，翻到上一页
      targetPage = (_centerIndex - 1).clamp(0, widget.pages.length - 1);
    }

    logger.debug("当前是否单一滑动方向: $singleDirection");
    logger.debug("开始滑动时的坐标: $dragStartX");
    logger.debug("滑动方向变更时的坐标: $turningPointX");
    logger.debug("抬起时的坐标: ${details.globalPosition.dx}");

    // 根据速度快速判断
    // if (velocity.abs() > velocityThreshold) {
    //   if (velocity < 0) {
    //     // 快速向右滑动，翻到上一页
    //     targetPage = (currentPage - 1).clamp(0, widget.pages.length - 1);
    //   } else {
    //     // 快速向左滑动，翻到下一页
    //     targetPage = (currentPage + 1).clamp(0, widget.pages.length - 1);
    //   }
    // } else {
    //   // 根据拖拽距离判断
    //   if (dragRatio > distanceThreshold) {
    //     // 向左滑动超过阈值，翻到下一页
    //     targetPage = (currentPage + 1).clamp(0, widget.pages.length - 1);
    //   } else if (dragRatio < -distanceThreshold) {
    //     // 向右滑动超过阈值，翻到上一页
    //     targetPage = (currentPage - 1).clamp(0, widget.pages.length - 1);
    //   }
    //   // 如果滑动距离不够，保持当前页面（targetPage = currentPage）
    // }

    // 执行翻页动画
    _animateToPage(targetPage);
  }

  void _goToPreviousPage() {
    if (_centerIndex > 0) {
      _animateToPage(_centerIndex - 1);
    } else {
      _animateToPage(_centerIndex); // 回弹效果
    }
  }

  void _goToNextPage() {
    final pages = ref
        .read(ReaderProviderService().pagesProvider_)
        .asData
        ?.value;
    if (pages == null) return;
    if (_centerIndex - _minIndex < totalPages - 1) {
      _animateToPage(_centerIndex + 1);
    } else {
      _animateToPage(_centerIndex); // 回弹效果
    }
  }

  void _animateToPage(int page) {
    if (isAnimating) return;
    final pages = ref
        .read(ReaderProviderService().pagesProvider_)
        .asData
        ?.value;
    if (pages == null) return;

    isAnimating = true;
    final targetPage = page.clamp(0, totalPages - 1);
    logger.debug(
      "Animating to page: $targetPage, Current center index: $_centerIndex",
    );
    pageController
        .animateToPage(
          targetPage,
          duration: animationDuration,
          curve: Curves.easeOutCubic,
        )
        .then((_) {
          isAnimating = false;
          if (_centerIndex != targetPage) {
            _centerIndex = targetPage;
            // widget.onPageChanged?.call(_currentPage);
          }
          final actualIndex = pageController.page?.round() ?? 0 + _minIndex;
          logger.debug(
            "Page changed to: $actualIndex, Center index: $_centerIndex",
          );
          // 向前加载：当接近最小索引时
          if (actualIndex <= _minIndex + 2 && !_isLoadingPrev) {
            _loadPreviousData();
          }

          // 向后加载：当接近最大索引时
          if (actualIndex >= _maxIndex - 2 && !_isLoadingNext) {
            _loadNextData();
          }
        });
  }

  // void _onPageChanged() {
  //   if (isAnimating) return;
  //   final actualIndex = pageController.page?.round() ?? 0 + _minIndex;
  //   // 向前加载：当接近最小索引时
  //   if (actualIndex <= _minIndex + 2 && !_isLoadingPrev) {
  //     _loadPreviousData();
  //   }

  //   // 向后加载：当接近最大索引时
  //   if (actualIndex == _maxIndex - 2 && !_isLoadingNext) {
  //     _loadNextData();
  //   }
  // }

  void _loadPreviousData() async {
    logger.debug("Loading previous data...");
    _isLoadingPrev = true;
  }

  void _loadNextData() async {
    logger.debug("Loading next data...");
    _isLoadingNext = true;
    final pageNum = await widget.fetchNextChapter();
    _maxIndex += pageNum;
    _isLoadingNext = false;
  }

  int get totalPages => _maxIndex - _minIndex + 1;

  @override
  Widget build(BuildContext context) {
    logger.debug(
      "Total pages: $totalPages, Min index: $_minIndex, Max index: $_maxIndex",
    );
    return GestureDetector(
      // onTapDown: PointerService().onTapDown,
      onTapUp: _onTapUp,
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: PageView.builder(
        controller: pageController,
        itemCount: totalPages,
        physics: const NeverScrollableScrollPhysics(),
        pageSnapping: false,
        itemBuilder: (context, index) {
          final actualIndex = index + _minIndex;
          logger.debug("Building page at index: $actualIndex");
          final page = widget.pages[actualIndex]!;
          return CustomPaint(
            foregroundPainter: ChineseLayoutPainter(page: page),
            size: Size(
              page.drawingArea.width + page.drawingArea.left * 2,
              page.drawingArea.height + page.drawingArea.top * 2,
            ),
          );
        },
      ),
    );
  }
}
