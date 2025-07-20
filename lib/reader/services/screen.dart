import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/reader/providers/pages.dart';
import 'package:wenku8x/reader/services/provider.dart';

class ReaderService {
  ReaderService._internal();

  static final ReaderService _instance = ReaderService._internal();

  factory ReaderService() {
    return _instance;
  }

  late WidgetRef ref;
  late BuildContext context;
  late PageController pageController;

  bool isAnimating = false;
  int currentPage = 0;
  final Duration animationDuration = const Duration(milliseconds: 300);

  init(WidgetRef widgetRef, BuildContext context) {
    ref = widgetRef;
    this.context = context;
    pageController = PageController();
  }

  void goToPreviousPage() {
    if (currentPage > 0) {
      _animateToPage(currentPage - 1);
    } else {
      _animateToPage(currentPage); // 回弹效果
    }
  }

  void goToNextPage() {
    final pages = ref
        .read(ReaderProviderService().pagesProvider_)
        .asData
        ?.value;
    if (pages == null) return;
    // if (currentPage < pages.pageCount - 1) {
    //   _animateToPage(currentPage + 1);
    // } else {
    //   _animateToPage(currentPage); // 回弹效果
    // }
  }

  void _animateToPage(int page) {
    if (isAnimating) return;
    // final pages = ref
    //     .read(ReaderProviderService().pagesProvider_)
    //     .asData
    //     ?.value;
    // if (pages == null) return;

    // isAnimating = true;
    // final targetPage = page.clamp(0, pages.pageCount - 1);

    // ReaderService().pageController
    //     .animateToPage(
    //       targetPage,
    //       duration: animationDuration,
    //       curve: Curves.easeOutCubic,
    //     )
    //     .then((_) {
    //       isAnimating = false;
    //       if (currentPage != targetPage) {
    //         currentPage = targetPage;
    //         // widget.onPageChanged?.call(_currentPage);
    //       }
    //     });
  }
}
