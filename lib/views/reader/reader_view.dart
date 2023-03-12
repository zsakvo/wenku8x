import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
import 'package:wenku8x/main.dart';
import 'package:wenku8x/modals/chapter.dart';
import 'package:wenku8x/utils/flash.dart';
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
  final distance = 8;
  double moveX = 0;
  // 按下座标
  double tapDownPos = 0.0;
  double tapDownPosY = 0.0;
  // 抬起座标
  double tapUpPos = 0.0;
  double tapUpPosY = 0.0;
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

  // 字体大小
  final fontSize = spInstance.getDouble("fontSize") ?? 1.2;
  // 字间距
  final lineSpace = spInstance.getDouble("lineSpace") ?? 1.5;

  @override
  Widget build(BuildContext context) {
    final log = useState("");
    // 当前主题
    final currentTheme = useState<ReaderTheme>(readerThemeList[spInstance.getInt("reader_theme") ?? 0]);
    // final currentTheme = useState<ReaderTheme>(readerThemeList[1]);
    // 加载状态
    final loading = useState(true);
    // 文档路径
    final dirFuture = useFuture(useMemoized(getApplicationDocumentsDirectory), initialData: null);
    // 目录请求
    final catalogFuture = useFuture<bool>(useMemoized(getCatalog), initialData: false);
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
return await ReaderJs.appendChapter(`$content`,"$title",$index);
"""));
      final page = (Platform.isIOS ? (res!.value as double).toInt() : res!.value) as int;
      Log.e(page, "refreshChapter");
      chapterPagesMap[index] = page;
      return page;
    }

    // 插入章节
    insertChapter(String content, String title, int index) async {
      final res = await webViewController.value?.callAsyncJavaScript(functionBody: """
return ReaderJs.insertChapter(`$content`,"$title",$index);
""");
      final page = (Platform.isIOS ? (res!.value as double).toInt() : res!.value) as int;
      chapterPagesMap[index] = page;
      currentIndex.value += page;
      return page;
    }

    // 刷新章节
    refreshChapter(String content, String title, int index) async {
      final res = (await webViewController.value?.callAsyncJavaScript(functionBody: """
return await ReaderJs.refreshChapter(`$content`,"$title",$index);
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

    // 设置字号
    setFontSize(double size) async {
      await webViewController.value!.evaluateJavascript(source: """
        ReaderJs.setFontSize($size,${currentIndex.value})
      """);
      chapterPagesMap.clear();
      // int t = 0;
      // for (var k in res.keys) {
      //   Log.d([k, res[k]]);
      //   int i = int.parse(k);
      //   int p = (Platform.isIOS ? (res[k] as double).toInt() : res[k]) as int;
      //   if (i < bookRecord.chapterIndex) {
      //     t += p;
      //   }
      //   chapterPagesMap[i] = p;
      // }
      // currentIndex.value = t + bookRecord.pageIndex;
      // webViewController.value!.scrollTo(x: (pageWidth * currentIndex.value).round(), y: 0, animated: false);
    }

    // 设置间距
    setLineSpacing(double lineSpacing) async {
      final res = (await webViewController.value!.evaluateJavascript(source: """
        ReaderJs.setLineSpacing($lineSpacing,${currentIndex.value})
      """) as Map<String, dynamic>);
      webViewController.value!.scrollTo(x: (pageWidth * currentIndex.value).round(), y: 0, animated: false);
      chapterPagesMap.clear();
      int t = 0;
      for (var k in res.keys) {
        Log.d([k, res[k]]);
        int i = int.parse(k);
        int p = (Platform.isIOS ? (res[k] as double).toInt() : res[k]) as int;
        chapterPagesMap[i] = p;
        if (i < bookRecord.chapterIndex) {
          t += p;
        }
      }
      currentIndex.value = t + bookRecord.pageIndex;
      webViewController.value!.scrollTo(x: (pageWidth * currentIndex.value).round(), y: 0, animated: false);
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
      tapUpPos = event.position.dx;
      tapUpPosY = event.position.dy;
      Log.d(longHitStatus, "up");
      if (longHitStatus == LongHitStatus.a) {
        longHitStatus = LongHitStatus.b;
        return;
      } else if (longHitStatus == LongHitStatus.b) {
        // longHitStatus = LongHitStatus.c;
        final d = sqrt(pow((tapUpPos - tapDownPos), 2) + pow((tapUpPosY - tapDownPosY), 2));
        if (d < 10) {
          // 当作点击事件
          clearLongHits();
          longHitStatus = LongHitStatus.c;
          return;
        }
        return;
      }

      if (menuStatus.value != Menu.none) {
        if (menuStatus.value == Menu.wrapper) {
          menuStatus.value = Menu.none;
        } else {
          closeAllSubMenus();
          menuStatus.value = Menu.wrapper;
        }
        return;
      }
      double res = (tapUpPos - tapDownPos);
      double resAbs = res.abs();
      int tmpIndex = currentIndex.value;
      if (resAbs > distance) {
        // ---如果是处于选中状态,直接拦截事件
        // if (longHitStatus != LongHitStatus.c) return;

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
        // if (longHitStatus != LongHitStatus.c) {
        //   clearLongHits();
        //   longHitStatus = LongHitStatus.c;
        //   return;
        // }

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
      // webViewController.value!.evaluateJavascript(source: """
      //   ReaderJs.enableLongHit()
      // """);
      tapDownPos = event.position.dx;
      tapDownPosY = event.position.dy;
    }

    // 手指移动
    onPointerMove(PointerMoveEvent event) {
      if (longHitStatus != LongHitStatus.c) return;
      webViewController.value!.evaluateJavascript(source: """
        ReaderJs.disableLongHit()
      """);
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
    initChapter(int index, {force = false, showLoading = true}) async {
      chapterPagesMap.clear();
      if (showLoading) loading.value = true;
      currentIndex.value = 0;
      await webViewController.value!.scrollTo(x: 0, y: 0, animated: false);
      // 直接一次性加载三章内容，滚动到正确位置后再展示
      final content = await fetchContent(index, force: force);
      await refreshChapter(content, catalog[index].name, index);
      currentIndex.value += bookRecord.pageIndex;
      await webViewController.value!.scrollTo(x: (pageWidth * (bookRecord.pageIndex)).round(), y: 0, animated: false);

      if (index > 0) {
        final preContent = await fetchContent(index - 1, force: force);
        await insertChapter(preContent, catalog[index - 1].name, index - 1);
      }
      if (index < catalog.length - 1) {
        final nextContent = await fetchContent(index + 1, force: force);
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
        Log.e("开始初始化");
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
                case 'loadSuccess':
                  // showErrorToast(context, "loadSuccess");
                  webviewControllerValue.evaluateJavascript(source: """
                    ReaderJs.init({
                      bookName: '${widget.name}',
                      horizontal: true,
                      marginHorizontal: 18,
                      marginVertical: 18,
                      textIndent: 36,
                      fontSize: $fontSize,
                      textAlign: 1, //0 start,1 justify,2 end,3 center
                      lineSpacing: $lineSpace,
                      backgroundColor: '${Util.getJsColor(currentTheme.value.readerBackgroundColor)}',
                      textColor: '${Util.getJsColor(currentTheme.value.readerTextColor)}',
                      infoColor: '${Util.getJsColor(currentTheme.value.readerInfoColor)}',
                      linkColor: '000000',
                      topExtraHeight: ${mediaQueryPadding.top},
                      bottomExtraHeight: ${mediaQueryPadding.bottom},
                      infoBarHeight: 32,
                      enableJsBridge:true,
                      enableScroll:false,
                      extraTitle: true,
                      isIOS: navigator.userAgent.includes('iPhone')
                    })
                  """);
                  break;
                case 'initDone':
                  Log.e(args);
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
        closeAllSubMenus();
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

    useEffect(() {
      spInstance.setInt("reader_theme", readerThemeList.indexOf(currentTheme.value));
      return () {};
    }, [currentTheme.value]);

    // useEffect(() {
    //   return () {
    //     webViewController.value!.loadData(data: "<html></html>");
    //   };
    // }, []);

    // -----

    return Material(
        child: WillPopScope(
            child: Stack(
              children: [
                Listener(
                    onPointerCancel: (event) {
                      webViewController.value!
                          .scrollTo(x: (pageWidth * (currentIndex.value)).round(), y: 0, animated: true);
                    },
                    onPointerMove: onPointerMove,
                    onPointerUp: (event) => onPointerUp(
                          event,
                        ),
                    onPointerDown: onPointerDown,
                    behavior: HitTestBehavior.translucent,
                    child: InAppWebView(
                      onRenderProcessGone: (controller, detail) {
                        showErrorToast(context, detail.didCrash);
                      },
                      onContentSizeChanged: (controller, oldContentSize, newContentSize) {},
                      onWebViewCreated: (controller) {
                        webViewController.value = controller;
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        // showErrorToast(context, consoleMessage.message);
                        log.value += "${consoleMessage.message}\n";
                        Log.d(consoleMessage.message);
                      },
                      onLongPressHitTestResult: (controller, hitTestResult) {
                        Log.e(hitTestResult.toJson());
                        if (hitTestResult.extra != null) {
                          longHitStatus = LongHitStatus.a;
                        }
                      },
                      gestureRecognizers: {
                        Factory<OneSequenceGestureRecognizer>(
                          () => LongPressGestureRecognizer(),
                        )
                      },
                      onLoadStop: (controller, url) {
                        // showErrorToast(context, "loadstop");
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
                  onForceRefresh: () {
                    initChapter(bookRecord.chapterIndex, force: true);
                  },
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
                  fontSize: fontSize,
                  lineSpace: lineSpace,
                  currentTheme: currentTheme.value,
                  onFontSizeSlideBarValueChangeEnd: (p0) async {
                    await setFontSize(p0);
                    spInstance.setDouble("fontSize", p0);
                    await initChapter(bookRecord.chapterIndex, showLoading: false);
                  },
                  onTextSpaceSlideBarValueChangeEnd: (p0) {
                    setLineSpacing(p0);
                    spInstance.setDouble("lineSpace", p0);
                    initChapter(bookRecord.chapterIndex);
                  },
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
                    ?
                    // const SizedBox.shrink()
                    Container(
                        color: currentTheme.value.readerBackgroundColor,
                        alignment: Alignment.center,
                        child: Text(
                          "章节加载中，请稍候",
                          style: TextStyle(fontSize: 15, color: currentTheme.value.readerInfoColor),
                        ))
                    : const SizedBox.shrink(),
                // Container(
                //   padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.top, horizontal: 16),
                //   width: MediaQuery.of(context).size.width,
                //   height: 360,
                //   color: Colors.green[50]!.withOpacity(0.7),
                //   child: SingleChildScrollView(
                //     child: Text(log.value),
                //   ),
                // )
              ],
            ),
            onWillPop: () async {
              Log.e("准备返回");
              webViewController.value!.loadUrl(urlRequest: URLRequest(url: WebUri("about:blank")));
              // if (menuStatus.value != Menu.none) {
              //   if (menuStatus.value != Menu.wrapper) {
              //     closeAllSubMenus();
              //   } else {
              //     menuTopKey.currentState?.close();
              //     menuBottomWrapperKey.currentState?.close();
              //   }
              //   return false;
              // }
              return true;
            }));
  }

  // 读取目录
  Future<bool> getCatalog() async {
    final aid = widget.aid;
    docDir = await getApplicationDocumentsDirectory();
    final dir = Directory("${docDir.path}/books/$aid");
    final file = File("${dir.path}/catalog.json");
    Log.e(file.existsSync(), "存在目录吗");
    if (file.existsSync()) {
      String str = file.readAsStringSync();
      var json = jsonDecode(str) as List<dynamic>;
      final arr = json.map((e) => Chapter(e['cid'], e['name']));
      catalog.addAll(arr);
      fetchCatalog();
      return true;
    } else {
      return await fetchCatalog();
    }
  }

  // 获取目录
  Future<bool> fetchCatalog() async {
    final aid = widget.aid;
    docDir = await getApplicationDocumentsDirectory();
    final dir = Directory("${docDir.path}/books/$aid");
    final file = File("${dir.path}/catalog.json");
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
      final cptJson = cpts
          .map((element) {
            // Log.e(element.json);
            return element.json;
          })
          .toList()
          .toString();
      file.writeAsString(cptJson);
      catalog.clear();
      catalog.addAll(cpts);
      return true;
    } else {
      return false;
    }
  }

  // 获取章节内容
  Future fetchContent(int index, {force = false}) async {
    final aid = widget.aid;
    final cid = catalog[index].cid;
    final title = catalog[index].name;
    final file = File("${docDir.path}/books/$aid/$cid.html");
    force = true;
    if (file.existsSync() && !force) {
      Log.e(index, "内容以存在");
      return file.readAsStringSync();
    } else {
      if (totalPage == 0) {
        menuCatalogKey.currentState!.close();
        menuBottomWrapperKey.currentState!.close();
      }
      var res = await API.getNovelContent(aid, cid);
      List<String> arr = res.split(RegExp(r"\n\s*|\s{2,}"));
      var exp = RegExp(r"<!--image-->\s*(.*?)\s*<!--image-->", dotAll: true);
      arr.removeRange(0, 2);
      String content = arr.map((e) {
        // if (title == "插图") {
        //   if (e.trim().isNotEmpty) return """<img src="${e.replaceAll("<!--image-->", "")}"/>""";
        //   return "";
        // } else {
        //   return """<p>$e</p>""";
        // }
        final matchs = exp.allMatches(e);
        if (matchs.isEmpty) {
          return """<p>$e</p>""";
        } else {
          return matchs
              .map((e) =>
                  """<div style="min-width:100%;min-height:100%;" ><img loading="lazy" src="${e.group(1)}"></img></div>""")
              .join("\n");
        }
      }).join("\n");
      // if (title == "插图") {
      //   content = """<div style="text-indent:0">$content</div>""";
      // }
      String html = """<html><head><meta name="viewport" content="width=device-width, user-scalable=no" />
    <title></title></head><style>p{text-align:justify;text-indent:2em;}h3{margin-bottom:42px;}</style><body>${title == '插图' ? '' : '<h3>$title</h3>'}$content</body></html>""";
      Log.e(file.path);
      file.writeAsString(html);
      return html;
    }
  }

  closeAllSubMenus() {
    menuCatalogKey.currentState?.close();
    menuConfigKey.currentState?.close();
    menuTextKey.currentState?.close();
    menuThemeKey.currentState?.close();
    menuProgressKey.currentState?.close();
  }
}
