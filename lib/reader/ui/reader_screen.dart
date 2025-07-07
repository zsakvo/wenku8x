import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/reader/helper/layout.dart';
import 'package:wenku8x/reader/providers/pages.dart';
import 'package:wenku8x/reader/service.dart';
import 'package:wenku8x/reader/ui/components/menus/bottom.dart';

class ReaderScreen extends StatefulHookConsumerWidget {
  const ReaderScreen({super.key, required this.book});
  final BookModel book;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  @override
  Widget build(BuildContext context) {
    ReaderService().init(widget.book);
    final pages = ref.watch(pagesProvider(widget.book));
    final colorScheme = Theme.of(context).colorScheme;
    final _pageController = PageController();
    return Material(
      color: colorScheme.surfaceContainer,
      child: switch (pages) {
        AsyncData(:final value) => Stack(
          children: [
            Listener(
              // onPointerMove: ref.read(provider.notifier).onPointerMove,
              // onPointerUp: ref.read(provider.notifier).onPointerUp,
              // onPointerDown: ref.read(provider.notifier).onPointerDown,
              child: ChineseLayoutPageView(
                layoutResult: value,
                pageController: _pageController,
              ),
            ),
            MenuBottom(isVisible: false),
          ],
        ),
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
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
    );
  }
}
