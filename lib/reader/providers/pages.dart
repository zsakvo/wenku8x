import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/catalog.dart';
import 'package:wenku8x/app/services/path.dart';
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
      padding: EdgeInsets.zero,
      bodyTextStyle: TextStyle(
        fontSize: 16,
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
