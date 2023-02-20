// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:wenku8x/data/scheme/book_record.dart';
// import 'package:wenku8x/http/api.dart';
// import 'package:wenku8x/modals/chapter.dart';
// import 'package:wenku8x/utils/log.dart';
// import 'package:wenku8x/views/reader/components/menu_bottom.dart';
// import 'package:wenku8x/views/reader/components/menu_catalog.dart';
// import 'package:wenku8x/views/reader/components/menu_config.dart';
// import 'package:wenku8x/views/reader/components/menu_text.dart';
// import 'package:wenku8x/views/reader/components/menu_top.dart';
// import 'package:wenku8x/views/reader/constants/html.dart';

// enum Menu { none, wrapper, catalog, theme, reader, text, config }

// enum Fetching { none, next, previous, refresh }

// class ReaderView extends StatefulHookConsumerWidget {
//   final String aid;
//   final String name;
//   const ReaderView({required this.aid, required this.name, Key? key}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ReaderViewState();
// }

// class _ReaderViewState extends ConsumerState<ReaderView> with TickerProviderStateMixin {
//   late Directory docDir;
//   late double statusBarHeight;
//   late double bottomBarHeight;
//   // 页面宽度
//   late dynamic pageWidth;
//   // 手指滑动判定
//   final distance = 8;
//   // 按下座标
//   double tapDownPos = 0.0;
//   // 抬起座标
//   double tapUpPos = 0.0;
//   // 位移比例
//   double extraRate = 1.0;
//   // 总页数
//   int totalPage = 0;

//   Fetching fetchStatus = Fetching.refresh;
//   Fetching pageStatue = Fetching.none;
//   Isar isar = Isar.getInstance()!;

//   late BookRecord bookRecord;

//   // 边界
//   int chapterCeil = 0;
//   int chapterFloor = 0;

//   final chapterPagesMap = {};
//   int currentChapterIndex = 0;
//   int currentChapterPage = 0;

//   String? previousChater;
//   String? nextChapter;

//   // 工具栏状态
//   // Menu menuStatus = Menu.none;
//   final menuBottomWrapperKey = GlobalKey<MenuBottomState>();
//   final menuTopKey = GlobalKey<MenuTopState>();
//   final menuCatalogKey = GlobalKey<MenuCatalogState>();
//   final menuTextKey = GlobalKey<MenuTextState>();
//   final menuConfigKey = GlobalKey<MenuConfigState>();

//   final _regExpBody = r'<body[^>]*>([\s\S]*)<\/body>';

//   @override
//   Widget build(BuildContext context) {
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

//     return Material(
//         child: Stack(
//       children: [
//         Listener(
//             onPointerMove: onPointerMove,
//             onPointerUp: (event) => onPointerUp(
//                   event,
//                 ),
//             onPointerDown: onPointerDown,
//             behavior: HitTestBehavior.translucent,
//             child: InAppWebView(
//               onWebViewCreated: (controller) {
//                 webViewController.value = controller;
//               },
//               gestureRecognizers: {
//                 Factory<OneSequenceGestureRecognizer>(
//                   () => LongPressGestureRecognizer(),
//                 )
//               },
//               onLoadStop: (controller, url) {
//                 controller.evaluateJavascript(source: """
//  ReaderJs.init({
//           bookName: '${widget.name}',
//           horizontal: true,
//           marginHorizontal: 18,
//           marginVertical: 18,
//           textIndent: 36,
//           fontSize:18,
//           textAlign: 1, //0 start,1 justify,2 end,3 center
//           lineSpacing: 1.4,
//           backgroundColor: 'fffffbff',
//           textColor: '000000',
//           linkColor: '000000',
//           topExtraHeight: ${mediaQuery.padding.top},
//           bottomExtraHeight: ${mediaQuery.padding.bottom},
//           infoBarHeight: 32,
//           enableJsBridge:true,
//           enableScroll:false
//         })
// """);
//               },
//               initialSettings: InAppWebViewSettings(
//                   pageZoom: 1,
//                   userAgent: "ReaderJs/NoScroll",
//                   verticalScrollBarEnabled: false,
//                   horizontalScrollBarEnabled: false,
//                   disableHorizontalScroll: true,
//                   disableVerticalScroll: true),
//             )),
//         MenuTop(
//           key: menuTopKey,
//           title: widget.name,
//           backgroundColor: toolBarBackgroundColor,
//         ),
//         MenuCatalog(
//           currentIndex: 0,
//           key: menuCatalogKey,
//           chapters: chapters.value,
//           backgroundColor: toolBarBackgroundColor,
//           onItemTap: (index, chapter) {
//             Log.d([index, chapter], "点击目录");
//             fetchStatus = Fetching.refresh;
//             loading.value = true;
//             totalPage = 0;
//             currentChapterPage = 0;
//             currentPage.value = 0;
//             currentChapterIndex = index;
//             fetchContent(chapter.cid, chapter.name);
//           },
//         ),
//         MenuText(
//           key: menuTextKey,
//           fontSize: 16,
//           lineSpace: 1.4,
//           onFontSizeSlideBarValueChangeEnd: (p0) {},
//           onTextSpaceSlideBarValueChangeEnd: (p0) {},
//           backgroundColor: toolBarBackgroundColor,
//           primaryColor: Theme.of(context).colorScheme.primary,
//           secondColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
//           tertiaryColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
//         ),
//         MenuConfig(
//           key: menuConfigKey,
//           // backgroundColor: toolBarBackgroundColor,
//           // primaryColor: Theme.of(context).colorScheme.primary,
//           // secondColor: Theme.of(context).colorScheme.primary.withOpacity(0.27),
//           // tertiaryColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//           horizontal: true,
//           volumeKey: true,
//           fullNext: true,
//           hideExtra: true,
//           // textColor: Theme.of(context).colorScheme.primary,
//           onChange: (key, value) {},
//         ),
//         MenuBottom(
//           key: menuBottomWrapperKey,
//           backgroundColor: toolBarBackgroundColor,
//           onCatalogTap: () {
//             if (menuStatus.value != Menu.catalog) {
//               menuStatus.value = Menu.catalog;
//             } else {
//               menuStatus.value = Menu.wrapper;
//             }
//           },
//           onStyleTap: () {},
//           onProgressTap: () {},
//           onTextTap: () {
//             Log.d("message");
//             if (menuStatus.value != Menu.text) {
//               menuStatus.value = Menu.text;
//             } else {
//               menuStatus.value = Menu.wrapper;
//             }
//           },
//           onConfigTap: () {
//             if (menuStatus.value != Menu.config) {
//               menuStatus.value = Menu.config;
//             } else {
//               menuStatus.value = Menu.wrapper;
//             }
//           },
//         ),
//         loading.value
//             ? Container(
//                 color: Theme.of(context).colorScheme.background,
//                 alignment: Alignment.center,
//                 child: Text(
//                   "章节加载中，请稍候",
//                   style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.secondary),
//                 ))
//             : const SizedBox.shrink()
//       ],
//     ));
//   }
// }
