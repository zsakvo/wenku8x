import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/models/catalog.dart';
import 'package:wenku8x/app/services/path.dart';
import 'package:wenku8x/app/ui/router.dart';
import 'package:wenku8x/reader/helper/layout.dart';
import 'package:wenku8x/reader/models/progress.dart';
import 'package:wenku8x/reader/services/progress.dart';
import 'package:wenku8x/reader/services/provider.dart';

part 'pages.g.dart';

@riverpod
class Pages extends _$Pages {
  final logger = Logger("Reader.Pages");
  int _latestChapterIndex = 0;
  int _firstChapterIndex = 0;
  late ChineseLayoutHelper _layoutHelper;
  @override
  FutureOr<Map<int, PageLayout>> build(BookModel book) async {
    final catalog = await ref.watch(
      ReaderProviderService().catalogProvider_.future,
    );
    final expandedChapters = catalog.volumes.expand(
      (volume) => volume.chapters,
    );
    late ProgressModel progress;
    if (await _progressFile.exists()) {
      try {
        progress = ProgressModel.fromJson(
          jsonDecode(await _progressFile.readAsString()),
        );
      } catch (e) {
        logger.error("Failed to read progress file: $e");
        // lastRead = expandedChapters.first;
        progress = ProgressModel(
          bookId: book.aid,
          chapterId: expandedChapters.first.cid,
          paragraphIndex: 0,
          lineIndex: 0,
        );
      }
    } else {
      logger.debug("Progress file not found, using first chapter.");
      progress = ProgressModel(
        bookId: book.aid,
        chapterId: expandedChapters.first.cid,
        paragraphIndex: 0,
        lineIndex: 0,
      );
    }
    ReaderProgressService().init(progress);
    final lastRead =
        expandedChapters.firstWhereOrNull(
          (chapter) => chapter.cid == progress.chapterId,
        ) ??
        expandedChapters.first;
    // final ChapterModel lastRead = catalog.volumes
    //     .expand((volume) => volume.chapters)
    //     .first;
    final txt = await _fetchChapterContent(lastRead.cid);
    _layoutHelper = ChineseLayoutHelper(
      bookName: book.name,
      topBarPadding: EdgeInsets.only(
        top: MediaQuery.of(rootNavigatorKey.currentContext!).padding.top,
        left: 20,
        right: 20,
      ),
      bottomBarPadding: EdgeInsets.only(
        bottom: MediaQuery.of(rootNavigatorKey.currentContext!).padding.bottom,
        left: 20,
        right: 20,
      ),
      topBarTextStyle: TextStyle(
        fontSize: 13,
        color: Theme.of(
          rootNavigatorKey.currentContext!,
        ).colorScheme.onSurface.withAlpha(100),
        fontWeight: FontWeight.w500,
      ),
      bottomBarTextStyle: TextStyle(
        fontSize: 13,
        color: Theme.of(
          rootNavigatorKey.currentContext!,
        ).colorScheme.onSurface.withAlpha(100),
        fontWeight: FontWeight.w500,
      ),
      titleTopSpacing: 40, // 将此参数调整为合理的值，控制标题与顶部的距离
      titleBottomBodySpacing: 40, // 这个参数正确地控制标题与正文的距离
      paragraphSpacing: 24,
      titleStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      bodySpacing: EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 24),
      bodyTextStyle: TextStyle(
        fontSize: 20,
        height: 1.5,
        color: Colors.black87,
      ),
    );
    final pages = _layoutHelper
        .calculateLayout(txt, title: lastRead.title, chapterId: lastRead.cid)
        .pages;
    logger.debug(
      "Calculated ${pages.length} pages for book: ${book.name}, last read chapter: ${lastRead.title}",
    );
    final res = pages.asMap().map((index, element) => MapEntry(index, element));
    return res;
  }

  List<ChapterModel> flatCatalog() {
    final catalog = ref
        .read(ReaderProviderService().catalogProvider_)
        .asData!
        .value;
    return catalog.volumes.expand((volume) => volume.chapters).toList();
  }

  Future<int> fetchNextChapter() async {
    logger.debug("Fetching next chapter...");
    final exsitingPageNum = state.asData?.value.length ?? 0;
    final flatCatalogRes = flatCatalog();
    final chapter = flatCatalogRes[_latestChapterIndex + 1];
    final txt = await _fetchChapterContent(chapter.cid);
    final pages = _layoutHelper
        .calculateLayout(txt, title: chapter.title, chapterId: chapter.cid)
        .pages;
    final pageMap = pages.asMap().map(
      (index, element) => MapEntry(exsitingPageNum + index, element),
    );
    final newPages = {...?state.asData?.value, ...pageMap};
    logger.debug(newPages);
    _latestChapterIndex++;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = AsyncData(newPages);
    });
    // 返回本次加载章节的页数，便于更新 maxIndex
    return pages.length;
  }

  FutureOr<String> _fetchChapterContent(String cid, {force = false}) async {
    final chapterFile = File(
      join(PathService().booksDirectory, book.aid, "$cid.txt"),
    );
    if (await chapterFile.exists() && !force) {
      final content = await chapterFile.readAsString();
      return content;
    } else {
      final content = await Api.getNovelContent(book.aid, cid);
      if (content == null || content.isEmpty) {
        throw Exception("Failed to fetch chapter content");
      }
      await chapterFile.create(recursive: true);
      await chapterFile.writeAsString(content);
      return content;
    }
  }

  File get _progressFile {
    return File(join(PathService().booksDirectory, book.aid, "progress.json"));
  }
}
