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
      ReaderCore? readerCore}) = _CoverReader;
}

class CoverReaderNotifier
    extends FamilyNotifier<CoverReader, (BuildContext, String, String)> {
  @override
  CoverReader build(arg) {
    // var core = ref.watch(readerCoreProvider(arg));
    ref.listen<ReaderCore>(readerCoreProvider(arg), onCoreChange);
    return CoverReader(name: arg.$2, aid: arg.$3, pages: [
      const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(),
        ),
      )
    ]);
  }

  Widget getPaintedPage(CustomPainter painter) {
    return SizedBox.expand(
      child: CustomPaint(
        foregroundPainter: painter,
        painter: BackgroundPainter(),
      ),
    );
  }

  updateRenderPages() {
    var painters = ref
        .read(readerCoreProvider(arg))
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
    if (pagePaintersMap.isNotEmpty) {
      // state = state.copyWith(pages: pages);
      updateRenderPages();
    }
  }
}

final coverReaderProvider = NotifierProvider.family<CoverReaderNotifier,
    CoverReader, (BuildContext, String, String)>(CoverReaderNotifier.new);
