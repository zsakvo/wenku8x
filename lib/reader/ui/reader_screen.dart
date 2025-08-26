import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/ui/components/loading/loading_indicator.dart';
import 'package:wenku8x/reader/helper/layout.dart';
import 'package:wenku8x/reader/models/progress.dart';
import 'package:wenku8x/reader/providers/menu_visible.dart';
import 'package:wenku8x/reader/providers/pages.dart';
import 'package:wenku8x/reader/services/pointer.dart';
import 'package:wenku8x/reader/services/progress.dart';
import 'package:wenku8x/reader/services/provider.dart';
import 'package:wenku8x/reader/services/screen.dart';
import 'package:wenku8x/reader/ui/components/core/slider/slider.dart';
import 'package:wenku8x/reader/ui/components/core/transformer/transformer.dart';
import 'package:wenku8x/reader/ui/components/menus/bookmark.dart';
import 'package:wenku8x/reader/ui/components/menus/bottom.dart';
import 'package:wenku8x/reader/ui/components/menus/catalog.dart';
import 'package:wenku8x/reader/ui/components/menus/config.dart';
import 'package:wenku8x/reader/ui/components/menus/top.dart';
import 'package:wenku8x/reader/ui/components/menus/typography.dart';

class ReaderScreen extends StatefulHookConsumerWidget {
  const ReaderScreen({super.key, required this.book});
  final BookModel book;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  @override
  Widget build(BuildContext context) {
    ReaderProviderService().init(widget.book);
    ReaderService().init(ref, context);
    PointerService().init(ref, context);
    final pages = ref.watch(ReaderProviderService().pagesProvider_);
    final menuVisible = ref.watch(menuProvider);
    final colorScheme = Theme.of(context).colorScheme;
    // final _pageController = PageController();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        final menuState = ref.read(ReaderProviderService().menuProvider_);
        if (menuState.subMenuVisible) {
          ref
              .read(ReaderProviderService().menuProvider_.notifier)
              .disposeSubMenus();
        } else if (menuState.bottomAndTopVisible) {
          ref
              .read(ReaderProviderService().menuProvider_.notifier)
              .toggleParent();
        } else {
          context.pop();
        }
      },
      child: Material(
        color: colorScheme.surfaceContainer,
        child: switch (pages) {
          AsyncData(:final value) => Stack(
            children: [
              SliderCore(
                pages: value,
                fetchNextChapter: ref
                    .read(ReaderProviderService().pagesProvider_.notifier)
                    .fetchNextChapter,
                onPageChanged: (page) {
                  logger.debug("Page content: $page");
                  logger.debug(
                    "Page content: ${page.paragraphs.first.lines.first}",
                  );
                  ReaderProgressService().update(page);
                },
              ),
              // GestureDetector(
              //   // onPointerMove: PointerService().onPointerMove,
              //   // onPointerUp: PointerService().onPointerUp,
              //   // onPointerDown: PointerService().onPointerDown,
              //   onTapDown: PointerService().onTapDown,
              //   onTapUp: PointerService().onTapUp,
              //   onPanStart: PointerService().onPanStart,
              //   onPanUpdate: PointerService().onPanUpdate,
              //   onPanEnd: PointerService().onPanEnd,
              //   child: PageView.builder(
              //     controller: ReaderService().pageController,
              //     itemCount: value.pageCount,
              //     physics: const NeverScrollableScrollPhysics(),
              //     pageSnapping: false,
              //     itemBuilder: (context, index) {
              //       return ChineseLayoutView(page: value.pages[index]);
              //     },
              //   ),
              // ),
              MenuCatalog(book: widget.book),
              MenuBookmark(),
              MenuTypography(),
              MenuConfig(),
              MenuBottom(isVisible: menuVisible.bottomVisible),
              MenuTop(bookName: widget.book.name),
            ],
          ),
          AsyncLoading() => Center(child: LoadingIndicator.contained()),
          _ => Container(
            color: colorScheme.surfaceContainer,
            child: Center(
              child: Text(
                "加载失败，请稍后再试",
                style: TextStyle(
                  color: colorScheme.onSurface.withAlpha(150),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        },
      ),
    );
  }
}
