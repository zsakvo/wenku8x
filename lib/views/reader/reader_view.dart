import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide MenuTheme;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/data/scheme/book_record.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/modals/chapter.dart';
import 'package:wenku8x/utils/log.dart';
import 'package:wenku8x/utils/util.dart';
import 'package:wenku8x/views/reader/components/menu_bottom.dart';
import 'package:wenku8x/views/reader/components/menu_catalog.dart';
import 'package:wenku8x/views/reader/components/menu_config.dart';
import 'package:wenku8x/views/reader/components/menu_progress.dart';
import 'package:wenku8x/views/reader/components/menu_text.dart';
import 'package:wenku8x/views/reader/components/menu_top.dart';
import 'package:wenku8x/views/reader/constants/html.dart';

import 'components/menu_theme.dart';
import 'constants/theme.dart';

enum Menu { none, wrapper, catalog, theme, progress, text, config }

enum ThemeX { monet, ama, hashibami, usuao, chigusa, sekichiku, namari, karasubo }

enum Fetching { none, next, previous }

// 实在不知道怎么起名了，a是长按刚撒手，b是长按已撒手，c是无长按状态
enum LongHitStatus { a, b, c }

class ReaderView extends StatefulHookConsumerWidget {
  final String aid;
  final String name;
  const ReaderView({required this.aid, required this.name, Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReaderViewState();
}

class _ReaderViewState extends ConsumerState<ReaderView> with TickerProviderStateMixin {
  late Directory docDir;
  late double statusBarHeight;
  late double bottomBarHeight;
  // 页面宽度
  late dynamic pageWidth;
  // 手指滑动判定
  final distance = 10;
  double moveX = 0;
  // 按下座标
  double tapDownPos = 0.0;
  // 抬起座标
  double tapUpPos = 0.0;
  // 位移比例
  double extraRate = 1.0;
  // 总页数
  int totalPage = 0;

  Fetching fetchStatus = Fetching.none;
  // Fetching pageStatue = Fetching.none;
  Isar isar = Isar.getInstance()!;

  BookRecord bookRecord = BookRecord()
    ..pageIndex = 0
    ..chapterIndex = 0;

  // 边界
  int chapterCeil = 0;
  int chapterFloor = 0;

  final chapterPagesMap = {};
  int currentChapterIndex = 0;
  int currentChapterPage = 0;

  final List<Chapter> catalog = [];

  // 是否处于选中状态
  // bool isLongHitStatus = false;
  LongHitStatus longHitStatus = LongHitStatus.c;

  // 相对当前章节的进度（给进度条用）
  // int currentPage = 0;

  // 工具栏状态
  // Menu menuStatus = Menu.none;
  final menuBottomWrapperKey = GlobalKey<MenuBottomState>();
  final menuTopKey = GlobalKey<MenuTopState>();
  final menuThemeKey = GlobalKey<MenuThemeState>();
  final menuCatalogKey = GlobalKey<MenuCatalogState>();
  final menuTextKey = GlobalKey<MenuTextState>();
  final menuConfigKey = GlobalKey<MenuConfigState>();
  final menuProgressKey = GlobalKey<MenuProgressState>();

  // final _regExpBody = r'<body[^>]*>([\s\S]*)<\/body>';

  @override
  Widget build(BuildContext context) {
    // 当前主题
    final currentTheme = useState<ReaderTheme>(readerThemeList[ThemeX.ama.index]);
    // 加载状态
    final loading = useState(true);
    // 文档路径
    final dirFuture = useFuture(useMemoized(getApplicationDocumentsDirectory), initialData: null);
    // 目录请求
    final catalogFuture = useFuture<bool>(useMemoized(fetchCatalog), initialData: false);
    // webview-controller
    final webViewController = useState<InAppWebViewController?>(null);
    // 页面尺寸数据
    final mediaQueryPadding = MediaQuery.of(context).padding;
    final mediaQuerySize = MediaQuery.of(context).size;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    // 当前页码（相对于总页数）
    final currentIndex = useState(0);
    // 章节内容
    // final chapterContent = useState(null);
    // 是否监听手势
    // final enableGestureListener = useState(true);
    // 菜单状态
    final menuStatus = useState<Menu>(Menu.none);
    // -----

    // 追加章节
    appendChapter(String content, String title, int index) async {
      final res = (await webViewController.value?.callAsyncJavaScript(functionBody: """
return await ReaderJs.appendChapter(`$content`,"$title");
"""));
      final page = (Platform.isIOS ? (res!.value as double).toInt() : res!.value) as int;
      Log.e(page, "refreshChapter");
      chapterPagesMap[index] = page;
      return page;
    }

    // 插入章节
    insertChapter(String content, String title, int index) async {
      final res = await webViewController.value?.callAsyncJavaScript(functionBody: """
return ReaderJs.insertChapter(`$content`,"$title");
""");
      final page = (Platform.isIOS ? (res!.value as double).toInt() : res!.value) as int;
      chapterPagesMap[index] = page;
      currentIndex.value += page;
      return page;
    }

    // 刷新章节
    refreshChapter(String content, String title, int index) async {
      final res = (await webViewController.value?.callAsyncJavaScript(functionBody: """
return await ReaderJs.refreshChapter(`$content`,"$title");
"""));
      final page = (Platform.isIOS ? (res!.value as double).toInt() : res!.value) as int;
      Log.e(page, "refreshChapter");
      chapterPagesMap[index] = page;
      return page;
    }

    // 更新样式
    updateElementStyle({required Color backgroundColor, required Color textColor, required Color infoColor}) async {
      final bColor = Util.getJsColor(backgroundColor);
      final tColor = Util.getJsColor(textColor);
      final iColor = Util.getJsColor(infoColor);
      return await webViewController.value?.evaluateJavascript(source: """
        ReaderJs.updateTheme(`$bColor`,`$tColor`,`$iColor`);
      """);
    }

    // 清除选中
    clearLongHits() {
      webViewController.value!.evaluateJavascript(source: """
        document.getSelection().empty()
      """);
    }

    saveRecord() {
      isar.writeTxnSync(
        () {
          isar.bookRecords.putSync(bookRecord);
        },
      );
    }

    // 手指抬起
    onPointerUp(PointerUpEvent event) async {
      Log.d(longHitStatus, "up");
      if (longHitStatus == LongHitStatus.a) {
        longHitStatus = LongHitStatus.b;
        return;
      }
      // else if (longHitStatus == LongHitStatus.b) {
      //   longHitStatus = LongHitStatus.c;
      //   return;
      // }
      if (menuStatus.value != Menu.none) {
        if (menuStatus.value == Menu.wrapper) {
          menuStatus.value = Menu.none;
        } else {
          closeAllSubMenus();
          menuStatus.value = Menu.wrapper;
        }
        return;
      }
      tapUpPos = event.position.dx;
      double res = (tapUpPos - tapDownPos);
      double resAbs = res.abs();
      int tmpIndex = currentIndex.value;
      if (resAbs > distance) {
        // ---如果是处于选中状态,直接拦截事件
        if (longHitStatus != LongHitStatus.c) return;

        if (res < 0) {
          tmpIndex = currentIndex.value + 1;
          bookRecord.pageIndex++;
        } else {
          tmpIndex = currentIndex.value - 1;
          bookRecord.pageIndex--;
        }
      } else {
        // 点击事件
        // ---如果是处于选中状态,直接拦截事件
        if (longHitStatus != LongHitStatus.c) {
          longHitStatus = LongHitStatus.c;
          return;
        }

        var tempWidth = pageWidth / (Platform.isAndroid ? devicePixelRatio : 1);
        if (tapUpPos > 2 * tempWidth / 3 && tapUpPos < tempWidth) {
          tmpIndex = currentIndex.value + 1;
          bookRecord.pageIndex++;
        } else if (tapUpPos < tempWidth / 3 && tapUpPos > 0) {
          tmpIndex = currentIndex.value - 1;
          bookRecord.pageIndex--;
        } else {
          Log.d("菜单响应");
          if (menuStatus.value == Menu.none) {
            menuStatus.value = Menu.wrapper;
          } else if (menuStatus.value == Menu.wrapper) {
            menuStatus.value = Menu.none;
          }
        }
      }
      await webViewController.value!.scrollTo(x: (pageWidth * tmpIndex).round(), y: 0, animated: true);
      currentIndex.value = tmpIndex;
    }

    // 手指落下
    onPointerDown(PointerDownEvent event) {
      // if (longHitStatus != LongHitStatus.c) return;
      moveX = 0;
      tapDownPos = event.position.dx;
    }

    // 手指移动
    onPointerMove(PointerMoveEvent event) {
      // if (longHitStatus != LongHitStatus.c) return;
      final dx = event.delta.dx;
      moveX += dx;
      if (moveX.abs() >= distance) {
        if (menuStatus.value == Menu.none && longHitStatus == LongHitStatus.c) {
          webViewController.value!.scrollBy(x: (-event.delta.dx * extraRate).round(), y: 0);
        }
      }
      // else {
      //   if (longHitStatus == LongHitStatus.b) {
      //     longHitStatus = LongHitStatus.c;
      //   }
      // }
    }

    // 初始化章节
    initChapter(int index) async {
      chapterPagesMap.clear();
      loading.value = true;
      currentIndex.value = 0;
      await webViewController.value!.scrollTo(x: 0, y: 0, animated: false);
      // 直接一次性加载三章内容，滚动到正确位置后再展示
      final content = await fetchContent(index);
      await refreshChapter(content, catalog[index].name, index);
      currentIndex.value += bookRecord.pageIndex;
      await webViewController.value!.scrollTo(x: (pageWidth * (bookRecord.pageIndex)).round(), y: 0, animated: false);
      if (index > 0) {
        final preContent = await fetchContent(index - 1);
        await insertChapter(preContent, catalog[index - 1].name, index - 1);
      }
      if (index < catalog.length - 1) {
        final nextContent = await fetchContent(index + 1);
        await appendChapter(nextContent, catalog[index + 1].name, index + 1);
      }
      loading.value = false;
    }

    // 初始化信息
    useEffect(() {
      final dirData = dirFuture.data;
      final catalogData = catalogFuture.data;
      final webviewControllerValue = webViewController.value;
      if (dirData != null && webviewControllerValue != null && catalogData!) {
        // 前置数据初始完毕，进入逻辑
        // 阅读记录
        bookRecord = isar.bookRecords.filter().aidEqualTo(widget.aid).distinctByAid().findFirstSync() ?? BookRecord()
          ..aid = widget.aid;
        // 临时初始化页面宽度
        pageWidth = (mediaQuerySize.width).floor();
        // 计算额外比例参数
        if (Platform.isAndroid) {
          extraRate = devicePixelRatio;
        }
        // 上下两栏高度
        statusBarHeight = mediaQueryPadding.top;
        bottomBarHeight = mediaQueryPadding.bottom;
        // webview 挂载回调
        webviewControllerValue.addJavaScriptHandler(
            handlerName: "jsBridge",
            callback: (args) {
              final handler = args[0];
              switch (handler) {
                case 'initDone':
                  pageWidth = args[1] * extraRate;
                  initChapter(bookRecord.chapterIndex);
                  break;
              }
            });
        // HTML容器加载
        webviewControllerValue.loadData(
            data: READER_APP, baseUrl: WebUri.uri(dirData.uri), allowingReadAccessTo: WebUri.uri(dirData.uri));
        // webviewControllerValue.loadUrl(
        //     urlRequest: URLRequest(url: WebUri("http://10.0.2.2:5173/")),
        //     allowingReadAccessTo: WebUri.uri(dirData.uri));
      }
      return () {};
    }, [dirFuture.data, catalogFuture.data, webViewController.value]);

    useEffect(() {
      if (!loading.value) {
        if (bookRecord.pageIndex == -1) {
          // 到了上一章
          bookRecord.chapterIndex--;
          bookRecord.pageIndex = chapterPagesMap[bookRecord.chapterIndex] - 1;
          if (chapterPagesMap[bookRecord.chapterIndex - 1] == null && bookRecord.chapterIndex > 0) {
            fetchContent(bookRecord.chapterIndex - 1).then((content) {
              insertChapter(content, catalog[bookRecord.chapterIndex - 1].name, bookRecord.chapterIndex - 1);
            });
          }
        } else if (bookRecord.pageIndex == chapterPagesMap[bookRecord.chapterIndex]) {
          // 到了下一章
          bookRecord.chapterIndex++;
          bookRecord.pageIndex = 0;
          if (chapterPagesMap[bookRecord.chapterIndex + 1] == null) {
            fetchContent(bookRecord.chapterIndex + 1).then((content) {
              appendChapter(content, catalog[bookRecord.chapterIndex + 1].name, bookRecord.chapterIndex + 1);
            });
          }
        }
        saveRecord();
      }
      return () {};
    }, [currentIndex.value, loading.value]);

    useEffect(() {
      final menu = menuStatus.value;
      if (menu == Menu.wrapper) {
        menuBottomWrapperKey.currentState?.open();
        menuTopKey.currentState?.open();
      } else if (menu == Menu.none) {
        menuBottomWrapperKey.currentState?.close();
        menuTopKey.currentState?.close();
      } else {
        menuTopKey.currentState?.close();
        closeAllSubMenus();
        switch (menu) {
          case Menu.none:
            break;
          case Menu.wrapper:
            break;
          case Menu.catalog:
            menuCatalogKey.currentState?.toggle();
            break;
          case Menu.theme:
            menuThemeKey.currentState?.toggle();
            break;
          case Menu.progress:
            menuProgressKey.currentState?.toggle();
            break;
          case Menu.text:
            menuTextKey.currentState?.toggle();
            break;
          case Menu.config:
            menuConfigKey.currentState?.toggle();
            break;
        }
      }
      return () {};
    }, [menuStatus.value]);

    // -----

    return Material(
        child: Stack(
      children: [
        Listener(
            onPointerMove: onPointerMove,
            onPointerUp: (event) => onPointerUp(
                  event,
                ),
            onPointerDown: onPointerDown,
            behavior: HitTestBehavior.translucent,
            child: InAppWebView(
              onWebViewCreated: (controller) {
                webViewController.value = controller;
              },
              onLongPressHitTestResult: (controller, hitTestResult) {
                Log.e(hitTestResult.toJson());
                longHitStatus = LongHitStatus.a;
              },
              gestureRecognizers: {
                Factory<OneSequenceGestureRecognizer>(
                  () => LongPressGestureRecognizer(),
                )
              },
              onLoadStop: (controller, url) {
                controller.evaluateJavascript(source: """
                  ReaderJs.init({
                    bookName: '${widget.name}',
                    horizontal: true,
                    marginHorizontal: 18,
                    marginVertical: 18,
                    textIndent: 36,
                    fontSize:18,
                    textAlign: 1, //0 start,1 justify,2 end,3 center
                    lineSpacing: 1.4,
                    backgroundColor: '${Util.getJsColor(currentTheme.value.readerBackgroundColor)}',
                    textColor: '${Util.getJsColor(currentTheme.value.readerTextColor)}',
                    infoColor: '${Util.getJsColor(currentTheme.value.readerInfoColor)}',
                    linkColor: '000000',
                    topExtraHeight: ${mediaQueryPadding.top},
                    bottomExtraHeight: ${mediaQueryPadding.bottom},
                    infoBarHeight: 32,
                    enableJsBridge:true,
                    enableScroll:false,
                    extraTitle: true
                  })
                """);
              },
              initialSettings: InAppWebViewSettings(
                  pageZoom: 1,
                  userAgent: "ReaderJs/NoScroll",
                  verticalScrollBarEnabled: false,
                  horizontalScrollBarEnabled: false,
                  disableHorizontalScroll: true,
                  disableVerticalScroll: true),
            )),
        MenuTop(
          key: menuTopKey,
          title: widget.name,
          currentTheme: currentTheme.value,
        ),
        MenuCatalog(
          key: menuCatalogKey,
          chapters: catalog,
          currentIndex: bookRecord.chapterIndex,
          currentTheme: currentTheme.value,
          // backgroundColor: pannelBackgroundColor,
          onItemTap: (index, chapter) {
            bookRecord.pageIndex = 0;
            menuStatus.value = Menu.none;
            bookRecord.chapterIndex = index;
            initChapter(index);
            // fetchStatus = Fetching.none;
            // loading.value = true;
            // totalPage = 0;
            // currentChapterPage = 0;
            // currentPage.value = 0;
            // currentChapterIndex = index;
            // fetchContent(chapter.cid, chapter.name);
          },
        ),
        MenuTheme(
          key: menuThemeKey,
          currentTheme: currentTheme.value,
          onThemeItemTap: (theme) async {
            await updateElementStyle(
                backgroundColor: theme.readerBackgroundColor,
                textColor: theme.readerTextColor,
                infoColor: theme.readerInfoColor);
            // await Future.delayed(const Duration(milliseconds: 300));
            currentTheme.value = theme;
          },
        ),
        MenuProgress(
          key: menuProgressKey,
          currentPage: bookRecord.pageIndex,
          totalPage: chapterPagesMap[bookRecord.chapterIndex] ?? 0,
          currentTheme: currentTheme.value,
          onNextTap: () {},
          onPreviousTap: () {},
          onProgressBarValueChangeEnd: (p0) async {
            final page = p0.toInt();
            final tmpIndex = currentIndex.value + (page - bookRecord.pageIndex);
            await webViewController.value!.scrollTo(x: (pageWidth * tmpIndex).round(), y: 0, animated: false);
            currentIndex.value = tmpIndex;
            bookRecord.pageIndex = page;
          },
        ),
        MenuText(
          key: menuTextKey,
          fontSize: 16,
          lineSpace: 1.4,
          currentTheme: currentTheme.value,
          onFontSizeSlideBarValueChangeEnd: (p0) {},
          onTextSpaceSlideBarValueChangeEnd: (p0) {},
          // backgroundColor: Colors.black,
          // primaryColor: Theme.of(context).colorScheme.primary,
          // secondColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
          // tertiaryColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
        MenuConfig(
          key: menuConfigKey,
          horizontal: true,
          volumeKey: true,
          fullNext: true,
          hideExtra: true,
          currentTheme: currentTheme.value,
          onChange: (key, value) {},
        ),
        MenuBottom(
          key: menuBottomWrapperKey,
          currentTheme: currentTheme.value,
          onCatalogTap: () {
            if (menuStatus.value != Menu.catalog) {
              menuStatus.value = Menu.catalog;
            } else {
              closeAllSubMenus();
              menuStatus.value = Menu.wrapper;
            }
          },
          onStyleTap: () {
            if (menuStatus.value != Menu.theme) {
              menuStatus.value = Menu.theme;
            } else {
              closeAllSubMenus();
              menuStatus.value = Menu.wrapper;
            }
          },
          onProgressTap: () {
            if (menuStatus.value != Menu.progress) {
              menuStatus.value = Menu.progress;
            } else {
              closeAllSubMenus();
              menuStatus.value = Menu.wrapper;
            }
          },
          onTextTap: () {
            if (menuStatus.value != Menu.text) {
              menuStatus.value = Menu.text;
            } else {
              closeAllSubMenus();
              menuStatus.value = Menu.wrapper;
            }
          },
          onConfigTap: () {
            if (menuStatus.value != Menu.config) {
              menuStatus.value = Menu.config;
            } else {
              closeAllSubMenus();
              menuStatus.value = Menu.wrapper;
            }
          },
        ),
        loading.value
            ? Container(
                color: currentTheme.value.readerBackgroundColor,
                alignment: Alignment.center,
                child: Text(
                  "章节加载中，请稍候",
                  style: TextStyle(fontSize: 15, color: currentTheme.value.readerInfoColor),
                ))
            : const SizedBox.shrink()
      ],
    ));
  }

  // 获取目录
  Future<bool> fetchCatalog() async {
    final aid = widget.aid;
    docDir = await getApplicationDocumentsDirectory();
    final dir = Directory("${docDir.path}/books/$aid");
    if (!dir.existsSync()) dir.createSync(recursive: true);
    List<Chapter> cpts = [];
    var res = await API.getNovelIndex(aid);
    if (res != null) {
      for (var element in res.children[2].children) {
        if (element.toString().length > 2) {
          int i = 0;
          for (var node in element.children) {
            if (node.toString().length > 2) {
              if (i != 0) {
                cpts.add(Chapter(node.getAttribute("cid").toString(), node.innerText));
              }
            }
            i++;
          }
        }
      }
      catalog.addAll(cpts);
      return true;
    } else {
      return false;
    }
  }

  // 获取章节内容
  Future fetchContent(int index) async {
    final cid = catalog[index].cid;
    final title = catalog[index].name;
    // final name = catalog[index].name;
    if (totalPage == 0) {
      menuCatalogKey.currentState!.close();
      menuBottomWrapperKey.currentState!.close();
    }
    var aid = widget.aid;
    var res = await API.getNovelContent(aid, cid);
    List<String> arr = res.split(RegExp(r"\n\s*|\s{2,}"));
    arr.removeRange(0, 2);
    String content = arr.map((e) {
      if (title == "插图") {
        if (e.trim().isNotEmpty) return """<img src="${e.replaceAll("<!--image-->", "")}"/>""";
        return "";
      } else {
        return """<p>$e</p>""";
      }
    }).join("\n");
    if (title == "插图") {
      content = """<div style="text-indent:0">$content</div>""";
    }
    String html = """<body>$content</body>""";
    final file = File("${docDir.path}/books/$aid/$cid.html");
    file.writeAsString(html);
    return html;
  }

  closeAllSubMenus() {
    menuCatalogKey.currentState?.close();
    menuConfigKey.currentState?.close();
    menuTextKey.currentState?.close();
    menuThemeKey.currentState?.close();
    menuProgressKey.currentState?.close();
  }
}
