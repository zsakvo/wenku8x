import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/catalog.dart';
import 'package:wenku8x/app/services/path.dart';
import 'package:wenku8x/app/ui/router.dart';
import 'package:wenku8x/reader/helper/layout.dart';
import 'package:wenku8x/reader/service.dart';

part 'pages.g.dart';

@riverpod
class Pages extends _$Pages {
  @override
  FutureOr<LayoutResult> build(String aid) async {
    final catalog = await ref.read(ReaderService().catalogProvider_.future);
    final ChapterModel lastRead = catalog.volumes
        .expand((volume) => volume.chapters)
        .first;
    final txt = await _fetchChapterContent(lastRead.cid);
    return ChineseLayoutHelper(
      title: lastRead.title,
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
      titleTopSpacing: 120, // 将此参数调整为合理的值，控制标题与顶部的距离
      titleBottomBodySpacing: 120, // 这个参数正确地控制标题与正文的距离
      titleStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(rootNavigatorKey.currentContext!).padding.top + 20,
        bottom:
            MediaQuery.of(rootNavigatorKey.currentContext!).padding.bottom + 32,
        left: 24,
        right: 24,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 20,
        height: 1.5,
        color: Colors.black87,
      ),
    ).calculateLayout(txt);
  }

  FutureOr<String> _fetchChapterContent(String cid, {force = false}) async {
    final chapterFile = File(
      join(PathService().booksDirectory, aid, "$cid.txt"),
    );
    if (await chapterFile.exists() && !force) {
      final content = await chapterFile.readAsString();
      return content;
    } else {
      final content = await Api.getNovelContent(aid, cid);
      if (content == null || content.isEmpty) {
        throw Exception("Failed to fetch chapter content");
      }
      await chapterFile.create(recursive: true);
      await chapterFile.writeAsString(content);
      return content;
    }
  }
}
