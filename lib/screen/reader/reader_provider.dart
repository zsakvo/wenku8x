import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/main.dart';
import 'package:wenku8x/screen/reader/themes/cherry.dart';
import 'package:wenku8x/screen/reader/themes/glacier.dart';
import 'package:wenku8x/screen/reader/themes/mulberry.dart';
import 'package:wenku8x/screen/reader/themes/spring.dart';
import 'package:wenku8x/screen/reader/themes/walnut.dart';
import 'package:wenku8x/utils/flash.dart';
import 'package:wenku8x/utils/log.dart';
import 'package:wenku8x/utils/render.dart';

part 'reader_provider.freezed.dart';
part 'reader_provider.g.dart';

@freezed
class Chapter with _$Chapter {
  const factory Chapter({
    required String cid,
    required String name,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
}

@freezed
class ReaderMenuState with _$ReaderMenuState {
  const ReaderMenuState._();
  const factory ReaderMenuState(
      {@Default(false) bool menuBottomVisible,
      @Default(false) bool menuTopVisible,
      @Default(false) bool menuCatalogVisible,
      @Default(false) bool menuThemeVisible,
      @Default(false) bool menuTextVisible,
      @Default(false) bool menuConfigVisible,
      @Default(false) bool progressVisible,
      @Default(0) double bottomBarHeight}) = _ReaderMenuState;

  bool get subMenusVisible {
    return menuThemeVisible ||
        menuTextVisible ||
        menuConfigVisible ||
        menuCatalogVisible;
  }

  bool get parentMenuVisible {
    return menuBottomVisible && menuTopVisible;
  }
}

@freezed
class Reader with _$Reader {
  const Reader._();
  const factory Reader({
    required String name,
    required String aid,
    @Default(0) int cIndex,
    @Default("mulberry") String themeId,
    @Default([]) List<Chapter> catalog,
    @Default(TextStyle(fontSize: 18, height: 1.7)) TextStyle textStyle,
    @Default([]) List<Widget> pages,
    @Default("") String cachedText,
    @Default(ReaderConfig()) ReaderConfig config,
  }) = _Reader;

  ThemeData get theme {
    return readerThemes.firstWhere((element) => element.id == themeId).theme;
  }

  TextStyle get computedTextStyle {
    return textStyle.copyWith(color: theme.colorScheme.onBackground);
  }
}

@freezed
class ReaderTheme with _$ReaderTheme {
  const factory ReaderTheme({
    required String name,
    required String id,
    required ThemeData theme,
  }) = _ReaderTheme;
}

@freezed
class ReaderConfig with _$ReaderConfig {
  const factory ReaderConfig({
    @Default(true) bool horizontalScroll, // 平移翻页
    @Default(false) bool verticalScroll, // 滚动翻页
    @Default(false) bool flickScroll, // 静止翻页
    @Default(false) bool simulationScroll, // 仿真翻页
    @Default(false) bool buttonScroll, // 音量键翻页
    @Default(false) bool globalNext, // 全局下一页
    @Default(false) bool fullScreen, // 全屏显示
    @Default(false) bool keepScreenOn, // 屏幕常亮
  }) = _ReaderConfig;
}

@freezed
class RecordMeta with _$RecordMeta {
  const factory RecordMeta({
    @Default(0) int cIndex,
    @Default(0) int pIndex,
  }) = _RecordMeta;

  factory RecordMeta.fromJson(Map<String, dynamic> json) =>
      _$RecordMetaFromJson(json);
}

class ReaderMenuNotifier extends AutoDisposeNotifier<ReaderMenuState> {
  @override
  ReaderMenuState build() {
    return const ReaderMenuState();
  }

  void toggleMenuBottom() {
    state = state.copyWith(menuBottomVisible: !state.menuBottomVisible);
  }

  void toggleMenuCatalog() {
    state = state.copyWith(menuCatalogVisible: !state.menuCatalogVisible);
  }

  void toggleMenuTop() {
    state = state.copyWith(menuTopVisible: !state.menuTopVisible);
  }

  void toggleBottomAndTop() {
    state = state.copyWith(
        menuBottomVisible: !state.menuBottomVisible,
        menuTopVisible: !state.menuTopVisible);
  }

  void showInitialBars() {
    state = state.copyWith(
        progressVisible: true, menuBottomVisible: true, menuTopVisible: true);
  }

  void reset() {
    state = const ReaderMenuState();
  }

  void setBottomBarHeight(double height) {
    state = state.copyWith(bottomBarHeight: height);
  }

  void dispatch({
    bool? menuBottomVisible,
    bool? menuTopVisible,
    bool? menuCatalogVisible,
    bool? menuThemeVisible,
    bool? menuTextVisible,
    bool? menuConfigVisible,
    bool? progressVisible,
  }) {
    state = state.copyWith(
      menuBottomVisible: menuBottomVisible ?? state.menuBottomVisible,
      menuTopVisible: menuTopVisible ?? state.menuTopVisible,
      menuCatalogVisible: menuCatalogVisible ?? state.menuCatalogVisible,
      menuThemeVisible: menuThemeVisible ?? state.menuThemeVisible,
      menuTextVisible: menuTextVisible ?? state.menuTextVisible,
      menuConfigVisible: menuConfigVisible ?? state.menuConfigVisible,
      progressVisible: progressVisible ?? state.progressVisible,
    );
  }
}

final readerMenuStateProvider =
    NotifierProvider.autoDispose<ReaderMenuNotifier, ReaderMenuState>(
        ReaderMenuNotifier.new);

class ReaderNotifier
    extends AutoDisposeFamilyNotifier<Reader, (String, String, int)> {
  (List<String>, String) cachedTextAndTitle = ([], "");
  bool lockLoading = false;
  double posX = 0;
  int? initCIndex;
  // int cIndex = 0;
  late Directory bookDir;
  late double screenWidth;
  late double screenHeight;
  late File metaFile;
  late PageController pageController = PageController(keepPage: true);
  late BuildContext ctx;
  late int pointDownPage;
  @override
  Reader build(arg) {
    final themeId = sp.getString("themeId");
    final textStyle = TextStyle(
        fontSize: sp.getDouble("fontSize") ?? 18,
        height: sp.getDouble("lineHeight") ?? 1.7);
    return Reader(
        name: arg.$1,
        aid: arg.$2,
        cIndex: arg.$3,
        themeId: themeId ?? "mulberry",
        textStyle: textStyle);
  }

  void init(BuildContext context, int cIndex) async {
    ctx = context;
    if (cIndex > -1) initCIndex = cIndex;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  Future initCatalog() async {
    final docDir = await getApplicationDocumentsDirectory();
    bookDir = Directory("${docDir.path}/books/${state.aid}");
    metaFile = File("${bookDir.path}/meta.json");
    final recordMeta = (initCIndex != null)
        ? RecordMeta(cIndex: initCIndex!, pIndex: 0)
        : (metaFile.existsSync()
            ? RecordMeta.fromJson(json.decode(metaFile.readAsStringSync()))
            : const RecordMeta());
    final file = File("${bookDir.path}/catalog.json");
    List<Chapter> chapters = [];
    if (file.existsSync()) {
      // 如果存在目录文件，直接从文件读取并更新目录
      chapters =
          (json.decode(file.readAsStringSync()) as List<dynamic>).map((e) {
        return Chapter(cid: e['cid'], name: e['name']);
      }).toList();
    } else {
      if (!bookDir.existsSync()) bookDir.createSync(recursive: true);
      chapters = await API.getNovelIndex(state.aid);
      file.writeAsString(jsonEncode(chapters));
    }
    state = state.copyWith(catalog: chapters, cIndex: recordMeta.cIndex);
  }

  Future<(List<String>, String)> fetchContentTextAndTitle(int? ci) async {
    final index = ci ?? state.cIndex;
    final cid = state.catalog[index].cid;
    final file = File("${bookDir.path}/$cid.txt");
    String text = file.existsSync()
        ? file.readAsStringSync()
        : await API.getNovelContent(state.aid, cid);
    // String text = await API.getNovelContent(state.aid, cid);
    List<String> textArr = text.split(RegExp(r"\n\s*|\s{2,}"));
    textArr.removeRange(0, 2);
    file.writeAsString(text);
    return (textArr, state.catalog[index].name);
  }

  List<Widget> splitPages(
      {required List<String> textArr, required String title, int? ci}) {
    final index = ci ?? state.cIndex;
    var s = DateTime.now();
    var list = RenderUtil.splitRichText(
        name: state.name,
        title: title,
        cIndex: index,
        ctx,
        paragraphHeight: 20,
        textArr: textArr,
        textStyle: state.computedTextStyle, testImage: (textLine) {
      RegExp regex = RegExp(r'<!--image-->(.*?)<!--image-->');
      Match? match = regex.firstMatch(textLine);

      if (match != null) {
        String imageUrl = match.group(1) ?? '';
        return (true, imageUrl);
      } else {
        return (false, textLine);
      }
    },
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 64, top: 36));
    var t = DateTime.now();
    Log.e('共${list.length}页，用时${t.difference(s).inMilliseconds}ms', "计算分页");
    return list;
  }

  getPageIndex(int pIndex, List<Widget> pages) {
    return pages.indexWhere((element) {
      final values = Map.from((element.key as ValueKey).value);
      return values['pIndex'] == pIndex;
    });
  }

  Future<List<Widget>> getPages({
    int? ci,
  }) async {
    final (textArr, title) = await fetchContentTextAndTitle(ci ?? state.cIndex);
    return splitPages(textArr: textArr, title: title, ci: ci ?? state.cIndex);
  }

// 探测是否需要额外加载
  Future _checkLoadingExtra({required int pIndex}) async {
    if (state.pages.isEmpty) return;
    final cIndex = state.cIndex;
    if (state.pages.length <= 4) {
      Log.e("同时加载");
      // 尽可能同时向前后追加章节
      if (cIndex < state.catalog.length - 1) {
        // 可以加载下一章
        await loadNextChapter();
        prepareCached();
      }
      if (cIndex > 0) {
        // 可以加载上一章
        await loadPreviousChapter();
        prepareCached(isPrevious: true, pIndex: pIndex);
      }
    } else if (pIndex < 3) {
      // 追加上一章
      if (cIndex > 0) {
        // 可以加载上一章
        await loadPreviousChapter();
        prepareCached(isPrevious: true, pIndex: pIndex);
      }
    } else if (pIndex > state.pages.length - 4) {
      // 追加下一章
      if (cIndex < state.catalog.length - 1) {
        // 可以加载下一章
        await loadNextChapter();
        prepareCached();
      }
    }
  }

  _cancelLoading() {
    ref.read(loadingProvider.notifier).state = false;
  }

  void initPages({int? cIndex, int? pIndex}) async {
    final pages = await getPages(ci: cIndex ?? state.cIndex);
    int pageIndex = 0;
    if (metaFile.existsSync()) {
      final meta =
          RecordMeta.fromJson(json.decode(metaFile.readAsStringSync()));
      pageIndex = getPageIndex(meta.pIndex, pages);
    }
    pageController.jumpToPage(initCIndex != null ? 0 : (pIndex ?? pageIndex));
    // pageController = PageController(
    //     initialPage: initCIndex != null ? 0 : (pIndex ?? pageIndex),
    //     keepPage: true);
    initCIndex = null;
    state = state.copyWith(pages: pages, cIndex: cIndex ?? state.cIndex);
    _checkLoadingExtra(pIndex: pIndex ?? pageIndex).then((_) {
      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        _updateRecordMeta();
        _cancelLoading();
      });
    });
  }

  Future loadNextChapter() async {
    if (lockLoading) return;
    lockLoading = true;
    int latestChapterIndex =
        Map.from((state.pages.last.key as ValueKey).value)['cIndex'];
    cachedTextAndTitle = await fetchContentTextAndTitle(latestChapterIndex + 1);
    lockLoading = false;
  }

  Future loadPreviousChapter() async {
    if (lockLoading) return;
    lockLoading = true;
    int latestChapterIndex =
        Map.from((state.pages.first.key as ValueKey).value)['cIndex'];
    cachedTextAndTitle = await fetchContentTextAndTitle(latestChapterIndex - 1);
    lockLoading = false;
  }

  void prepareCached(
      {isPrevious = false, cancelLoading = true, int pIndex = 0}) {
    if (lockLoading || cachedTextAndTitle.$1.isEmpty) return;
    lockLoading = true;
    int latestChapterIndex =
        Map.from((state.pages.last.key as ValueKey).value)['cIndex'];
    var nextPages = splitPages(
        ci: latestChapterIndex + (isPrevious ? -1 : 1),
        title: cachedTextAndTitle.$2,
        textArr: cachedTextAndTitle.$1);
    if (!isPrevious) {
      state = state.copyWith(pages: [...state.pages, ...nextPages]);
      if (cancelLoading) _cancelLoading();
    } else {
      state = state.copyWith(pages: [...nextPages, ...state.pages]);
      // 自动更新页码
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pageController.jumpToPage(nextPages.length + pIndex);
        if (cancelLoading) _cancelLoading();
      });
    }
    lockLoading = false;
    cachedTextAndTitle = ([], "");
  }

  void _updateRecordMeta() {
    final page = pageController.page!.round();
    final values = Map.from((state.pages[page].key as ValueKey).value);
    int currentChapterIndex = values['cIndex'];
    int currentParagraphIndex = values['pIndex'];
    String recordMetaString = json.encode(
        RecordMeta(cIndex: currentChapterIndex, pIndex: currentParagraphIndex)
            .toJson());
    if (!metaFile.existsSync()) metaFile.createSync(recursive: true);
    metaFile.writeAsString(recordMetaString);
  }

  void onPageScrollEnd() {
    if (state.pages.isEmpty) return;
    final page = pageController.page!.round();
    final values = Map.from((state.pages[page].key as ValueKey).value);
    int currentChapterIndex = values['cIndex'];
    if (state.cIndex != currentChapterIndex) {
      Future(() {
        state = state.copyWith(cIndex: currentChapterIndex);
      });
    }
    if (page == state.pages.length - 1) {
      prepareCached();
    }
    // int currentParagraphIndex = values['pIndex'];
    // String recordMetaString = json.encode(
    //     RecordMeta(cIndex: currentChapterIndex, pIndex: currentParagraphIndex)
    //         .toJson());
    // if (!metaFile.existsSync()) metaFile.createSync(recursive: true);
    // metaFile.writeAsString(recordMetaString);
    _updateRecordMeta();
  }

  onPointerMove(PointerMoveEvent event) {
    if (ref.read(readerMenuStateProvider).subMenusVisible) {
      return;
    }
    if (ref.read(readerMenuStateProvider).parentMenuVisible) {
      return;
    }
    // Log.e(event.delta.dx);
    // 当移动距离 posX 大于 5 个像素的时候开始跟随
    final dx = event.position.dx - posX;
    if (dx.abs() > 5) {
      // 最后一章和第一章禁止额外滚动
      double offset = pageController.offset - event.delta.dx;
      if (offset <= 0) {
        offset = 0;
      } else {
        offset = offset > pageController.position.maxScrollExtent
            ? pageController.position.maxScrollExtent
            : offset;
      }
      pageController.jumpTo(offset);
    }
  }

  _checkFirstPage() {
    if (pageController.offset == 0) {
      // Show.error("前面什么都木有~");
      return true;
    }
    return false;
  }

  _checkLastPage() {
    if (pageController.offset == pageController.position.maxScrollExtent) {
      Show.error("已经是最后一页了~");
      return true;
    }
    return false;
  }

  onPointerUp(PointerUpEvent event) {
    // 如果子菜单开启，则不响应翻页 只关闭子菜单
    if (ref.read(readerMenuStateProvider).subMenusVisible) {
      ref.read(readerMenuStateProvider.notifier).dispatch(
            menuCatalogVisible: false,
            menuThemeVisible: false,
            menuTextVisible: false,
            menuConfigVisible: false,
            menuTopVisible: true,
            menuBottomVisible: true,
          );
      return;
    }
    // 如果父菜单开启，则不响应翻页，只关闭父菜单
    if (ref.read(readerMenuStateProvider).parentMenuVisible) {
      ref.read(readerMenuStateProvider.notifier).reset();
      return;
    }
    final dx = event.position.dx;
    final dy = event.position.dy;
    final deltaX = dx - posX;
    // Log.e(dx);
    // 检测 dx 绝对值
    if (deltaX.abs() < 5) {
      // 如果开启了子菜单，则隐藏子菜单
      if (ref.read(readerMenuStateProvider).subMenusVisible) {
        ref.read(readerMenuStateProvider.notifier).dispatch(
              menuCatalogVisible: false,
              menuThemeVisible: false,
              menuTextVisible: false,
              menuConfigVisible: false,
              menuTopVisible: true,
              menuBottomVisible: true,
            );
        return;
      } else {
        if (ref.read(readerMenuStateProvider).menuBottomVisible) {
          ref.read(readerMenuStateProvider.notifier).toggleBottomAndTop();
        } else {
          // 仅在屏幕中央 1/3 的区域内点击才会触发菜单栏
          if ((dy > screenHeight / 3 && dy < screenHeight / 3 * 2) &&
              (dx > screenWidth / 3 && dx < screenWidth / 3 * 2)) {
            ref.read(readerMenuStateProvider.notifier).toggleBottomAndTop();
          }
          // 如果点击屏幕右侧 1/3 则翻到下一页
          else if (dx > screenWidth / 3 * 2) {
            if (_checkLastPage()) return;
            pageController.nextPage(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeInOut);
          }
          // 如果点击左侧 1/3 翻到上一页
          else if (dx < screenWidth / 3) {
            if (_checkFirstPage()) return;
            pageController.previousPage(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeInOut);
          }
        }
      }
    } else {
      if (deltaX < -10) {
        if (_checkLastPage()) return;
        pageController.animateToPage(pointDownPage + 1,
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeInOut);
      } else if (deltaX > 10) {
        if (_checkFirstPage()) return;
        pageController.animateToPage(pointDownPage - 1,
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeInOut);
      } else {
        pageController.animateToPage(pointDownPage,
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeInOut);
      }
    }
  }

  onPointerDown(PointerDownEvent event) {
    posX = event.position.dx;
    pointDownPage = pageController.page!.round();
  }

  void refresh({int? cIndex}) async {
    ref.read(loadingProvider.notifier).state = true;
    ref.read(readerMenuStateProvider.notifier).reset();
    state = state.copyWith(
      pages: [],
      catalog: [],
    );
    String recordMetaString = json
        .encode(RecordMeta(cIndex: cIndex ?? state.cIndex, pIndex: 0).toJson());
    if (!metaFile.existsSync()) metaFile.createSync(recursive: true);
    metaFile.writeAsString(recordMetaString);
    await Future.delayed(const Duration(milliseconds: 300));
    await initCatalog();
    // ignore: use_build_context_synchronously
    initPages(cIndex: cIndex ?? state.cIndex, pIndex: 0);
    if (pageController.hasClients) {
      pageController.jumpToPage(0);
    }
  }

  void jumpToIndex(int index) {
    refresh(cIndex: index);
  }

  void updateTheme(String themeId) {
    state = state.copyWith(themeId: themeId);
  }

  void update(Reader reader) {
    state = reader;
  }

  void updateTextStyle(TextStyle textStyle) {
    state = state.copyWith(textStyle: textStyle);
    refresh();
  }

  void updateConfig({
    bool? horizontalScroll,
    bool? verticalScroll,
    bool? flickScroll,
    bool? simulationScroll,
    bool? buttonScroll,
    bool? globalNext,
    bool? fullScreen,
    bool? keepScreenOn,
  }) {
    bool hs = state.config.horizontalScroll;
    bool vs = state.config.verticalScroll;
    bool fs = state.config.flickScroll;
    bool ss = state.config.simulationScroll;
    if (horizontalScroll == true) {
      hs = true;
      vs = false;
      fs = false;
      ss = false;
    } else if (verticalScroll == true) {
      hs = false;
      vs = true;
      fs = false;
      ss = false;
    } else if (flickScroll == true) {
      hs = false;
      vs = false;
      fs = true;
      ss = false;
    } else if (simulationScroll == true) {
      hs = false;
      vs = false;
      fs = false;
      ss = true;
    }
    state = state.copyWith(
        config: state.config.copyWith(
      horizontalScroll: hs,
      verticalScroll: vs,
      flickScroll: fs,
      simulationScroll: ss,
      buttonScroll: buttonScroll ?? state.config.buttonScroll,
      globalNext: globalNext ?? state.config.globalNext,
      fullScreen: fullScreen ?? state.config.fullScreen,
      keepScreenOn: keepScreenOn ?? state.config.keepScreenOn,
    ));
  }
}

final readerProvider = NotifierProvider.family
    .autoDispose<ReaderNotifier, Reader, (String, String, int)>(
        ReaderNotifier.new);

final List<ReaderTheme> readerThemes = [
  ReaderTheme(name: '白茶', id: "mulberry", theme: mulberryTheme),
  ReaderTheme(name: '春水', id: "spring", theme: springTheme),
  ReaderTheme(name: '冰川', id: "glacier", theme: glacierTheme),
  ReaderTheme(name: '樱桃', id: "cherry", theme: cherryTheme),
  ReaderTheme(name: '胡桃', id: "walnut", theme: walnutTheme),
];

final loadingProvider = StateProvider.autoDispose<bool>((ref) {
  return true;
});
