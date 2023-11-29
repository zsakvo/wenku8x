// 覆盖翻页
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/reader/core/cover/provider.dart';

import '../background.dart';
import '../shadow.dart';

class CoverReader extends StatefulHookConsumerWidget {
  const CoverReader({super.key, required this.name, required this.aid});

  final String name;
  final String aid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CoverReaderState();
}

class _CoverReaderState extends ConsumerState<CoverReader>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller =
        useAnimationController(duration: const Duration(milliseconds: 300));
    final provider =
        coverReaderProvider((context, widget.name, widget.aid, controller));
    final coverReader = ref.watch(provider);
    var pagesScheduler = coverReader.readerCore?.pagesScheduler;
    double currentPagePos = ref.watch(currentPagePosProvider);
    return GestureDetector(
      onPanDown: ref.read(provider.notifier).onPanDown,
      onPanUpdate: ref.read(provider.notifier).onPanUpdate,
      onPanEnd: ref.read(provider.notifier).onPanEnd,
      child: Stack(
          children: pagesScheduler == null
              ? [
                  const Center(
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(),
                    ),
                  )
                ]
              : [
                  CustomPaint(
                    foregroundPainter: pagesScheduler.getPagePainter(
                        coverReader.currentChapter,
                        coverReader.currentPage + 1),
                    painter: BackgroundPainter(),
                    size: MediaQuery.of(context).size,
                  ),
                  Positioned(
                    left: currentPagePos,
                    top: 0,
                    child: CustomPaint(
                      foregroundPainter: pagesScheduler.getPagePainter(
                          coverReader.currentChapter, coverReader.currentPage),
                      painter: BackgroundPainter(),
                      size: MediaQuery.of(context).size,
                    ),
                  ),
                  Positioned(
                      left: currentPagePos +
                          MediaQuery.of(context).size.width -
                          1,
                      child: CustomPaint(
                        painter: BookPageShadowPainter(),
                        size: Size(1, MediaQuery.of(context).size.height),
                      )),
                ]),
    );
  }
}
