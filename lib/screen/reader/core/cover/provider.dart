import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/reader/core/background.dart';
import 'package:wenku8x/screen/reader/core/provider.dart';
import 'package:wenku8x/utils/log.dart';

part 'provider.freezed.dart';

@freezed
class CoverReader with _$CoverReader {
  const CoverReader._();

  const factory CoverReader(
      {required String name,
      required String aid,
      required List<Widget> pages,
      @Default(0) int currentChapter,
      @Default(0) int currentPage,
      ReaderCore readerCore}) = _CoverReader;
}

class CoverReaderNotifier extends FamilyNotifier<CoverReader,
    (BuildContext, String, String, AnimationController)> {
  late double downPos;
  late double currentPos;

  AnimationController get _controller => arg.$4;

  // 初始化 controller 为 animationController

  @override
  CoverReader build(arg) {
    _controller.addListener(pageControllerListener);
    _controller.addStatusListener(pageControllerStatusListener);
    // var core = ref.watch(readerCoreProvider(arg));
    ref.listen<ReaderCore>(
        readerCoreProvider((arg.$1, arg.$2, arg.$3)), onCoreChange);
    return CoverReader(name: arg.$2, aid: arg.$3, pages: [
      // const Center(
      //   child: SizedBox(
      //     width: 32,
      //     height: 32,
      //     child: CircularProgressIndicator(),
      //   ),
      // )
    ]);
  }

  Widget getPaintedPage(CustomPainter painter) {
    return CustomPaint(
      foregroundPainter: painter,
      painter: BackgroundPainter(),
      size: MediaQuery.of(arg.$1).size,
    );
  }

  updateRenderPages() {
    var painters = ref
        .read(readerCoreProvider((arg.$1, arg.$2, arg.$3)))
        .pagesScheduler
        .pagePaintersMap[state.currentChapter]!;
    var pages = [
      getPaintedPage(painters[state.currentPage + 1]),
      Positioned(
        left: 0,
        top: 0,
        child: getPaintedPage(painters[state.currentPage]),
      )
    ];
    state = state.copyWith(pages: pages);
  }

  onCoreChange(ReaderCore? c1, ReaderCore c2) {
    var pagePaintersMap = c1?.pagesScheduler.pagePaintersMap ?? {};
    if (pagePaintersMap.isEmpty) return;
    // var pages = pagePaintersMap[0]!.map((e) => getPaintedPage(e)).toList();
    Log.e([c1, c2], 'ccc');
    if (pagePaintersMap.isNotEmpty) {
      // state = state.copyWith(pages: pages);
      // updateRenderPages();
      Log.e(c1?.pagesScheduler.pagePaintersMap, 'pagePaintersMap');
      state = state.copyWith(readerCore: c1);
    }
  }

  onPanDown(DragDownDetails details) {
    Log.d('onPanDown');
    downPos = details.localPosition.dx;
  }

  onPanUpdate(DragUpdateDetails details) {
    var move = details.localPosition;
    currentPos = move.dx;
    var delta = move.dx - downPos;
    ref.read(currentPagePosProvider.notifier).state = delta;
  }

  onPanEnd(DragEndDetails details) {
    Log.d('onPanEnd');
    Log.e(currentPos);
    toNextPage();
  }

  pageControllerListener() {
    ref.read(currentPagePosProvider.notifier).state =
        -currentPos + -_controller.value * MediaQuery.of(arg.$1).size.width;
  }

  pageControllerStatusListener(AnimationStatus status) {
    // Log.d('pageControllerStatusListener');
    switch (status) {
      case AnimationStatus.completed:
        state = state.copyWith(currentPage: state.currentPage + 1);
        // _controller.reset();
        // ref.read(currentPagePosProvider.notifier).state =
        //     -MediaQuery.of(arg.$1).size.width - 6;
        break;
      case AnimationStatus.dismissed:
        break;
      default:
    }
  }

  toNextPage() {
    Log.d("松手了");
    _controller.forward(from: 0.0);
  }
}

final coverReaderProvider = NotifierProvider.family<
    CoverReaderNotifier,
    CoverReader,
    (
      BuildContext,
      String,
      String,
      AnimationController
    )>(CoverReaderNotifier.new);

final currentPagePosProvider = StateProvider.autoDispose<double>((ref) {
  return 0.0;
});
