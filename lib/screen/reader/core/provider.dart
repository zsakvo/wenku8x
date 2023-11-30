import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/screen/reader/reader_provider.dart';
import 'package:wenku8x/utils/log.dart';
import 'package:wenku8x/utils/splitter.dart';
part 'provider.freezed.dart';

@freezed
class ReaderCore with _$ReaderCore {
  const ReaderCore._();

  const factory ReaderCore(
      {required String name,
      required String aid,
      required PagesScheduler pagesScheduler,
      @Default(true) bool isLoading,
      @Default(0) int cIndex,
      @Default("mulberry") String themeId,
      @Default(PageConfig()) PageConfig pageConfig}) = _ReaderCore;
}

final catalogProvider =
    FutureProvider.family<List<Chapter>, String>((ref, aid) async {
  final docDir = await getApplicationDocumentsDirectory();
  final bookDir = Directory("${docDir.path}/books/$aid");
  final file = File("${bookDir.path}/catalog.json");
  List<Chapter> chapters = [];
  if (file.existsSync()) {
    chapters = (json.decode(file.readAsStringSync()) as List<dynamic>).map((e) {
      return Chapter(cid: e['cid'], name: e['name']);
    }).toList();
  } else {
    if (!bookDir.existsSync()) bookDir.createSync(recursive: true);
    chapters = await API.getNovelIndex(aid);
    file.writeAsString(jsonEncode(chapters));
  }
  return chapters;
});

class PagesScheduler {
  int chapterIndex;
  int pageIndex;
  Map<int, List<CustomPainter>> pagePaintersMap = {};
  PagesScheduler({this.chapterIndex = 0, this.pageIndex = 0});

  void setChapterPages(int index, List<CustomPainter> pagePainters) {
    pagePaintersMap[index] = pagePainters;
  }

  List<dynamic> getChapterPagePainters(int index) {
    return pagePaintersMap[index]!;
  }

  CustomPainter getPagePainter(int chapterIndex, int pageIndex) {
    final chapterPainters = pagePaintersMap[chapterIndex] ?? [];
    return chapterPainters[pageIndex];
  }

  clear() {
    pagePaintersMap.clear();
  }
}

class ReaderCoreNotifier
    extends FamilyNotifier<ReaderCore, (BuildContext, String, String)> {
  late List<Chapter> catalog;
  late String bookPath;
  late double width;
  late double height;
  late double topBarHeight;
  late double bottomBarHeight;
  @override
  ReaderCore build((BuildContext, String, String) arg) {
    _initLayoutSize(arg.$1);
    ref.watch(catalogProvider(arg.$3)).whenData((_) => _init(catalogValue: _));
    // _init();
    return ReaderCore(
        name: arg.$2, aid: arg.$3, pagesScheduler: PagesScheduler());
  }

  _initLayoutSize(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    topBarHeight = MediaQuery.of(context).viewPadding.top;
    bottomBarHeight = MediaQuery.of(context).viewPadding.bottom;
  }

  _init({
    List<Chapter>? catalogValue,
  }) async {
    Log.e(catalogValue, 'cc');
    catalog = catalogValue!;
    bookPath =
        "${(await getApplicationDocumentsDirectory()).path}/books/${state.aid}";
    _initReaderConfig();
    _initPageConfig();
    _initPage();
  }

  _initReaderConfig() {
    // TODO: 读取配置
  }

  _initPageConfig() {
    // TODO: 生成渲染配置
  }

  _initPage({int? chapterIndex}) async {
    // 如果不传入 chapterIndex 则自行读取进度
    final loadChapterIndex = chapterIndex ?? state.cIndex;
    final fetchRes = await _fetchContentTextAndTitle(loadChapterIndex);
    final (textArr, title) = fetchRes;
    final splitter = PageSplitter(
      width: width,
      height: height,
      title: title,
      name: state.name,
      paragraphs: textArr,
      config: state.pageConfig,
    );
    state.pagesScheduler
        .setChapterPages(loadChapterIndex, splitter.getPainters());
    state = state.copyWith(isLoading: false);
  }

  Future<(List<String>, String)> _fetchContentTextAndTitle(
      int chapterIndex) async {
    final cid = catalog[chapterIndex].cid;
    final file = File("$bookPath/$cid.txt");
    String text = file.existsSync()
        ? file.readAsStringSync()
        : await API.getNovelContent(state.aid, cid);
    List<String> textArr = text.split(RegExp(r"\n\s*|\s{2,}"));
    textArr.removeRange(0, 2);
    file.writeAsString(text);
    return (textArr, catalog[chapterIndex].name);
  }
}

final readerCoreProvider = NotifierProviderFamily<ReaderCoreNotifier,
    ReaderCore, (BuildContext, String, String)>(ReaderCoreNotifier.new);
