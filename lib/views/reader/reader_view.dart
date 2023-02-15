import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/data/scheme/book_record.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/modals/chapter.dart';
import 'package:wenku8x/utils/log.dart';
import 'package:wenku8x/views/reader/components/menu_bottom.dart';
import 'package:wenku8x/views/reader/components/menu_catalog.dart';
import 'package:wenku8x/views/reader/components/menu_config.dart';
import 'package:wenku8x/views/reader/components/menu_text.dart';
import 'package:wenku8x/views/reader/components/menu_top.dart';
import 'package:wenku8x/views/reader/html.dart';

enum Menu { none, wrapper, catalog, theme, reader, text, config }

enum Fetching { none, next, previous }

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

  late BookRecord bookRecord;

  // 边界
  int chapterCeil = 0;
  int chapterFloor = 0;

  final chapterPagesMap = {};
  int currentChapterIndex = 0;
  int currentChapterPage = 0;

  final List<Chapter> catalog = [];

  // 工具栏状态
  // Menu menuStatus = Menu.none;
  final menuBottomWrapperKey = GlobalKey<MenuBottomState>();
  final menuTopKey = GlobalKey<MenuTopState>();
  final menuCatalogKey = GlobalKey<MenuCatalogState>();
  final menuTextKey = GlobalKey<MenuTextState>();
  final menuConfigKey = GlobalKey<MenuConfigState>();

  final _regExpBody = r'<body[^>]*>([\s\S]*)<\/body>';

  @override
  Widget build(BuildContext context) {
    // 加载状态
    final loading = useState(true);
    // 文档路径
    final dirFuture = useFuture(useMemoized(getApplicationDocumentsDirectory), initialData: null);
    // 目录请求
    final catalogFuture = useFuture(useMemoized(fetchCatalog), initialData: []);
    // webview-controller
    final webViewController = useState<InAppWebViewController?>(null);
    // 页面尺寸数据
    final mediaQueryPadding = MediaQuery.of(context).padding;
    final mediaQuerySize = MediaQuery.of(context).size;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    // 当前页码（相对于总页数）
    final currentIndex = useState(0);
    // 总内容映射
    final chaptersMap = useState({}); // {index:{title:"",page:0,content:""}}
    // 章节内容
    // final chapterContent = useState(null);
    // 是否监听手势
    final enableGestureListener = useState(true);
    // -----

    // 追加章节
    appendChapter(String content, String title) {
      return webViewController.value?.evaluateJavascript(source: """
        ReaderJs.appendChapter(`$content`,"$title");
      """);
    }

    // 插入章节
    insertChapter(String content, String title) {
      return webViewController.value?.evaluateJavascript(source: """
        ReaderJs.insertChapter(`$content`,"$title");
      """);
    }

    // 刷新章节
    refreshChapter(String content, String title) {
      return webViewController.value?.evaluateJavascript(source: """
        ReaderJs.refreshChapter(`$content`,"$title");
      """);
    }

    // 获取章节
    // fetchChapter(int index) async {
    //   final content = await fetchContent(index);
    //   chapterContent.value = content;
    // }

    saveRecord() {
      isar.writeTxnSync(
        () {
          isar.bookRecords.putSync(bookRecord);
        },
      );
    }

    // 手指抬起
    onPointerUp(PointerUpEvent event) {
      if (!enableGestureListener.value) return;
      tapUpPos = event.position.dx;
      double res = (tapUpPos - tapDownPos);
      double resAbs = res.abs();
      if (resAbs > distance) {
        if (res < 0) {
          currentIndex.value++;
          bookRecord.pageIndex++;
          // currentChapterPage++;
          // pageStatue = Fetching.next;
        } else {
          currentIndex.value--;
          bookRecord.pageIndex--;
          // currentChapterPage--;
          // pageStatue = Fetching.previous;
        }
      } else {
        // 点击事件
        var tempWidth = pageWidth / (Platform.isAndroid ? devicePixelRatio : 1);
        if (tapUpPos > 2 * tempWidth / 3 && tapUpPos < tempWidth) {
          currentIndex.value++;
          bookRecord.pageIndex++;
        } else if (tapUpPos < tempWidth / 3 && tapUpPos > 0) {
          currentIndex.value--;
          bookRecord.pageIndex--;
        }
      }
      Log.d(bookRecord.pageIndex);
      webViewController.value!.scrollTo(x: (pageWidth * currentIndex.value).round(), y: 0, animated: true);
    }

    // 手指落下
    onPointerDown(PointerDownEvent event) {
      tapDownPos = event.position.dx;
    }

    // 手指移动
    onPointerMove(PointerMoveEvent event) {
      final dx = event.delta.dx;
      // if (dx.abs() >= distance) {
      if (enableGestureListener.value) {
        webViewController.value!.scrollBy(x: (-event.delta.dx * extraRate).round(), y: 0);
      }
      // }
    }

    // 初始化章节
    initChapter(int index) async {
      // 直接一次性加载三章内容，滚动到正确位置后再展示
      final content = await fetchContent(index);
      int page = (await refreshChapter(content, catalog[index].name));
      chapterPagesMap[index] = page;
      currentIndex.value += bookRecord.pageIndex;
      await webViewController.value!.scrollTo(x: (pageWidth * (bookRecord.pageIndex)).round(), y: 0, animated: false);
      if (index > 0) {
        final preContent = await fetchContent(index - 1);
        int pagePre = (await insertChapter(preContent, catalog[index - 1].name));
        chapterPagesMap[index - 1] = pagePre;
        currentIndex.value += pagePre;
      }
      if (index < catalog.length - 1) {
        final nextContent = await fetchContent(index + 1);
        int pageNext = (await appendChapter(nextContent, catalog[index + 1].name));
        chapterPagesMap[index + 1] = pageNext;
      }
      loading.value = false;
    }

    // 初始化信息
    useEffect(() {
      final dirData = dirFuture.data;
      final catalogData = catalogFuture.data;
      final webviewControllerValue = webViewController.value;
      if (dirData != null && webviewControllerValue != null && catalogData != null) {
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
                  Log.d(args, "HTML 初始化成功");
                  pageWidth = args[1] * extraRate;
                  initChapter(bookRecord.chapterIndex);
                  break;
              }
            });
        // HTML容器加载
        webviewControllerValue.loadData(
            data: READER_APP, baseUrl: WebUri.uri(dirData.uri), allowingReadAccessTo: WebUri.uri(dirData.uri));
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
              insertChapter(content, catalog[bookRecord.chapterIndex - 1].name);
            });
          }
        } else if (bookRecord.pageIndex == chapterPagesMap[bookRecord.chapterIndex]) {
          // 到了下一章
          bookRecord.chapterIndex++;
          bookRecord.pageIndex = 0;
          if (chapterPagesMap[bookRecord.chapterIndex + 1] == null) {
            fetchContent(bookRecord.chapterIndex + 1).then((content) {
              appendChapter(content, catalog[bookRecord.chapterIndex + 1].name);
            });
          }
        }
        Log.d([bookRecord.pageIndex, chapterPagesMap]);
        saveRecord();
      }
      return () {};
    }, [currentIndex.value, loading.value]);

    // -----

//     final loading = useState(true);
//     // 这里维护一个全局的页码，用来计算滚动宽度
//     final currentPage = useState(-1);
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//     final chapters = useState<List<Chapter>>([]);
//     final webViewController = useState<InAppWebViewController?>(null);
//     final enableGestureListener = useState(true);
//     final menuStatus = useState<Menu>(Menu.none);
//     final topBaseHeight = MediaQuery.of(context).viewPadding.top + 48;
//     final toolBarBackgroundColor = Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3);
//     final dir = useFuture(useMemoized(getApplicationDocumentsDirectory), initialData: null);
//     final appInit = useState(false);
//     final tmpChapter = useState<String?>(null);

//     // 获取目录
//     fetchCatalog(String aid) async {
//       docDir = await getApplicationDocumentsDirectory();
//       final dir = Directory("${docDir.path}/books/$aid");
//       if (!dir.existsSync()) dir.createSync(recursive: true);
//       List<Chapter> cpts = [];
//       var res = await API.getNovelIndex(aid);
//       if (res != null) {
//         for (var element in res.children[2].children) {
//           if (element.toString().length > 2) {
//             int i = 0;
//             for (var node in element.children) {
//               if (node.toString().length > 2) {
//                 if (i != 0) {
//                   cpts.add(Chapter(node.getAttribute("cid").toString(), node.innerText));
//                 }
//               }
//               i++;
//             }
//           }
//         }
//         chapters.value = cpts;
//       }
//     }

//     // 获取内容
//     Future fetchContent(String cid, String chapterName) async {
//       if (totalPage == 0) {
//         menuCatalogKey.currentState!.close();
//         menuBottomWrapperKey.currentState!.close();
//       }
//       var aid = widget.aid;
//       var res = await API.getNovelContent(aid, cid);
//       List<String> arr = res.split(RegExp(r"\n\s*|\s{2,}"));
//       arr.removeRange(0, 2);
//       String content = arr.map((e) => """<p>$e</p>""").join("\n");

//       String html = """<body>$content</body>""";
//       final file = File("${docDir.path}/books/$aid/$cid.html");
//       tmpChapter.value = html + (tmpChapter.value == html ? " " : "");
//       // Log.d(html, cid);
//       file.writeAsStringSync(html);
//     }

//     onPointerDown(PointerDownEvent event) {
//       tapDownPos = event.position.dx;
//     }

//     onPointerMove(PointerMoveEvent event) {
//       if (enableGestureListener.value) {
//         webViewController.value!.scrollBy(x: (-event.delta.dx * extraRate).round(), y: 0);
//       }
//     }

//     onPointerUp(
//       PointerUpEvent event,
//     ) async {
//       if (!enableGestureListener.value) return;
//       tapUpPos = event.position.dx;
//       double res = (tapUpPos - tapDownPos);
//       double resAbs = res.abs();
//       if (resAbs > distance) {
//         if (res < 0) {
//           currentPage.value++;
//           currentChapterPage++;
//           pageStatue = Fetching.next;
//         } else {
//           currentPage.value--;
//           currentChapterPage--;
//           pageStatue = Fetching.previous;
//         }
//       } else {
//         // 视为点击事件
//         double tapUpPosY = event.position.dy;
//         if ((tapUpPos > screenWidth / 3 && tapUpPos < 2 * screenWidth / 3) &&
//             (tapUpPosY > screenHeight / 3 && tapUpPosY < 2 * screenHeight / 3)) {
//           // 菜单唤醒区域
//           // 如果菜单未显示，则展示第一层菜单
//           if (menuStatus.value == Menu.none) {
//             menuStatus.value = Menu.wrapper;
//           } else if (menuStatus.value == Menu.wrapper) {
//             menuStatus.value = Menu.none;
//           } else if (menuStatus.value == Menu.catalog ||
//               menuStatus.value == Menu.text ||
//               menuStatus.value == Menu.config) {
//             menuStatus.value = Menu.wrapper;
//           }
//         } else {
//           if (menuStatus.value == Menu.wrapper) {
//             menuStatus.value = Menu.none;
//           } else if (menuStatus.value == Menu.catalog ||
//               menuStatus.value == Menu.text ||
//               menuStatus.value == Menu.config) {
//             menuStatus.value = Menu.wrapper;
//           }
//         }
//       }
//       webViewController.value!.scrollTo(x: (pageWidth * currentPage.value).round(), y: 0, animated: true);
//     }

//     saveRecord() {
//       isar.writeTxnSync(
//         () {
//           isar.bookRecords.putSync(bookRecord
//             ..chapterIndex = currentChapterIndex
//             ..pageIndex = currentChapterPage);
//         },
//       );
//     }

//     useEffect(() {
//       bookRecord = isar.bookRecords.filter().aidEqualTo(widget.aid).distinctByAid().findFirstSync() ?? BookRecord()
//         ..aid = widget.aid;
//       pageWidth = (mediaQuery.size.width * mediaQuery.devicePixelRatio).floor();
//       if (Platform.isAndroid) {
//         extraRate = mediaQuery.devicePixelRatio;
//       }
//       statusBarHeight = mediaQuery.padding.top;
//       bottomBarHeight = mediaQuery.padding.bottom;
//       currentChapterIndex = bookRecord.chapterIndex;
//       currentChapterPage = bookRecord.pageIndex;
//       fetchCatalog(widget.aid);
//       return () {};
//     }, []);

//     useEffect(() {
//       final initData = appInit.value;
//       var cv = chapters.value;
//       if (initData && cv.isNotEmpty) {
//         // fetchContent(cv[currentChapterIndex].cid, cv[currentChapterIndex].name);
//         currentPage.value = currentChapterPage;
//       }
//       return () {};
//     }, [appInit.value, chapters.value]);

//     useEffect(() {
//       final dirData = dir.data;
//       var controller = webViewController.value;
//       if (controller != null && dirData != null) {
//         Log.d(dirData.uri, "uri");
//         controller.addJavaScriptHandler(
//           handlerName: "jsBridge",
//           callback: (args) {
//             Log.d(args, "args");
//             final handler = args[0];
//             switch (handler) {
//               case 'initDone':
//                 Log.d("初始化成功");
//                 appInit.value = true;
//                 pageWidth = args[1] * extraRate;
//                 break;
//               case 'notifySize':
//                 loading.value = false;
//                 totalPage += args[1] as int;
//                 if (pageStatue == Fetching.previous) {
//                   chapterPagesMap[currentChapterIndex - 1] = args[1] as int;
//                   currentPage.value += args[1] as int;
//                 } else if (pageStatue == Fetching.next) {
//                   chapterPagesMap[currentChapterIndex + 1] = args[1] as int;
//                 } else {
//                   chapterPagesMap[currentChapterIndex] = args[1] as int;
//                   webViewController.value!.scrollTo(x: (pageWidth * currentChapterPage).round(), y: 0, animated: false);
//                 }
//                 saveRecord();
//                 break;
//             }
//           },
//         );
//         controller.loadData(
//             data: READER_APP, baseUrl: WebUri.uri(dirData.uri), allowingReadAccessTo: WebUri.uri(dirData.uri));
//       }

//       return () {};
//     }, [dir.data, webViewController.value]);

//     useEffect(() {
//       final tmpChapterData = tmpChapter.value;
//       if (tmpChapterData != null) {
//         if (fetchStatus == Fetching.next) {
//           webViewController.value!.evaluateJavascript(source: """
// ReaderJs.appendChapter(`$tmpChapterData`,"${chapters.value[currentChapterIndex + 1].name}");
// """);
//         } else if (fetchStatus == Fetching.previous) {
//           webViewController.value!.evaluateJavascript(source: """
// ReaderJs.insertChapter(`$tmpChapterData`,"${chapters.value[currentChapterIndex - 1].name}");
// """);
//         } else if (fetchStatus == Fetching.refresh) {
//           webViewController.value!.evaluateJavascript(source: """
// ReaderJs.refreshChapter(`$tmpChapterData`,"${chapters.value[currentChapterIndex].name}");
// """);
//         }
//         fetchStatus = Fetching.none;
//       }
//       return () {};
//     }, [tmpChapter.value]);

//     useEffect(() {
//       if (currentPage.value > -1) {
//         if (currentPage.value == totalPage - 3 && fetchStatus == Fetching.none && pageStatue == Fetching.next) {
//           Log.d("要加载下一章了");
//           fetchStatus = Fetching.next;
//           var cpts = chapters.value;
//           int newIndex = currentChapterIndex + 1;
//           fetchContent(cpts[newIndex].cid, cpts[newIndex].name);
//         } else if (currentPage.value == 2 && fetchStatus == Fetching.none && pageStatue == Fetching.previous) {
//           Log.d("要加载上一章了");
//           fetchStatus = Fetching.previous;
//           var cpts = chapters.value;
//           if (currentChapterIndex >= 1) {
//             int newIndex = currentChapterIndex - 1;
//             fetchContent(cpts[newIndex].cid, cpts[newIndex].name);
//           }
//         } else if (fetchStatus == Fetching.refresh) {
//           var cpts = chapters.value;
//           fetchContent(cpts[currentChapterIndex].cid, cpts[currentChapterIndex].name);
//         }

//         final ceil = chapterPagesMap[currentChapterIndex];
//         if (currentChapterPage == ceil) {
//           currentChapterIndex++;
//           currentChapterPage = 0;
//         } else if (currentChapterPage == -1) {
//           currentChapterIndex--;
//           currentChapterPage = chapterPagesMap[currentChapterIndex] - 1;
//         }

//         // Log.d([chapterPagesMap, currentChapterIndex, currentChapterPage], "信息探测");

//         saveRecord();
//       }
//       return () {};
//     }, [currentPage.value]);

//     // 工具条状态监听
//     useEffect(() {
//       if (menuStatus.value != Menu.none) {
//         if (menuStatus.value == Menu.wrapper) {
//           Log.d("显示最外层菜单");
//           menuBottomWrapperKey.currentState!.open();
//           menuTopKey.currentState!.open();
//           menuCatalogKey.currentState!.close();
//           menuTextKey.currentState!.close();
//           menuConfigKey.currentState!.close();
//         } else if (menuStatus.value == Menu.catalog) {
//           Log.d("显示目录菜单");
//           menuCatalogKey.currentState!.open();
//           menuTopKey.currentState!.close();
//         } else if (menuStatus.value == Menu.text) {
//           Log.d("显示排版菜单");
//           menuTextKey.currentState!.open();
//           // menuTopKey.currentState!.close();
//         } else if (menuStatus.value == Menu.config) {
//           Log.d("显示配置菜单");
//           menuConfigKey.currentState!.open();
//           // menuTopKey.currentState!.close();
//         }
//       } else {
//         Log.d("收起菜单");
//         menuBottomWrapperKey.currentState?.close();
//         menuTopKey.currentState?.close();
//         menuConfigKey.currentState?.close();
//       }
//       return () {};
//     }, [menuStatus.value]);

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
                    backgroundColor: 'fffffbff',
                    textColor: '000000',
                    linkColor: '000000',
                    topExtraHeight: ${mediaQueryPadding.top},
                    bottomExtraHeight: ${mediaQueryPadding.bottom},
                    infoBarHeight: 32,
                    enableJsBridge:true,
                    enableScroll:false
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
          backgroundColor: Colors.black,
        ),
        MenuCatalog(
          key: menuCatalogKey,
          chapters: const [],
          backgroundColor: Colors.black,
          onItemTap: (index, chapter) {
            Log.d([index, chapter], "点击目录");
            fetchStatus = Fetching.none;
            loading.value = true;
            totalPage = 0;
            currentChapterPage = 0;
            // currentPage.value = 0;
            currentChapterIndex = index;
            // fetchContent(chapter.cid, chapter.name);
          },
        ),
        MenuText(
          key: menuTextKey,
          fontSize: 16,
          lineSpace: 1.4,
          onFontSizeSlideBarValueChangeEnd: (p0) {},
          onTextSpaceSlideBarValueChangeEnd: (p0) {},
          backgroundColor: Colors.black,
          primaryColor: Theme.of(context).colorScheme.primary,
          secondColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
          tertiaryColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
        MenuConfig(
          key: menuConfigKey,
          backgroundColor: Colors.black,
          primaryColor: Theme.of(context).colorScheme.primary,
          secondColor: Theme.of(context).colorScheme.primary.withOpacity(0.27),
          tertiaryColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          horizontal: true,
          volumeKey: true,
          fullNext: true,
          hideExtra: true,
          textColor: Theme.of(context).colorScheme.primary,
          onChange: (key, value) {},
        ),
        MenuBottom(
          key: menuBottomWrapperKey,
          backgroundColor: Colors.black,
          onCatalogTap: () {
            // if (menuStatus.value != Menu.catalog) {
            //   menuStatus.value = Menu.catalog;
            // } else {
            //   menuStatus.value = Menu.wrapper;
            // }
          },
          onStyleTap: () {},
          onProgressTap: () {},
          onTextTap: () {
            Log.d("message");
            // if (menuStatus.value != Menu.text) {
            //   menuStatus.value = Menu.text;
            // } else {
            //   menuStatus.value = Menu.wrapper;
            // }
          },
          onConfigTap: () {
            // if (menuStatus.value != Menu.config) {
            //   menuStatus.value = Menu.config;
            // } else {
            //   menuStatus.value = Menu.wrapper;
            // }
          },
        ),
        loading.value
            ? Container(
                color: Theme.of(context).colorScheme.background,
                alignment: Alignment.center,
                child: Text(
                  "章节加载中，请稍候",
                  style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.secondary),
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
    // final name = catalog[index].name;
    if (totalPage == 0) {
      menuCatalogKey.currentState!.close();
      menuBottomWrapperKey.currentState!.close();
    }
    var aid = widget.aid;
    var res = await API.getNovelContent(aid, cid);
    List<String> arr = res.split(RegExp(r"\n\s*|\s{2,}"));
    arr.removeRange(0, 2);
    String content = arr.map((e) => """<p>$e</p>""").join("\n");

    String html = """<body>$content</body>""";
    final file = File("${docDir.path}/books/$aid/$cid.html");
    file.writeAsString(html);
    return html;
  }
}
