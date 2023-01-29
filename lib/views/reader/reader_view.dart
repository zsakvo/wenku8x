import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/modals/chapter.dart';
import 'package:wenku8x/utils/log.dart';

import 'page_string.dart';

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
  late dynamic pageWidth;
  final distance = 24;
  double tapDownPos = 0.0;
  double tapUpPos = 0.0;
  double extraRate = 1.0;
  @override
  Widget build(BuildContext context) {
    final loading = useState(true);
    final currentPage = useState(0);
    final padding = MediaQuery.of(context).padding;
    final chapters = useState<List<Chapter>>([]);
    final fileUri = useState<String?>(null);
    final webViewController = useState<InAppWebViewController?>(null);
    final enableGestureListener = useState(true);

    // 获取目录
    fetchCatalog(String aid) async {
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
        chapters.value = cpts;
      }
    }

    // 获取内容
    Future fetchContent(String aid, String cid, String chapterName) async {
      var res = await API.getNovelContent(aid, cid);
      List<String> arr = res.split(RegExp(r"\n\s*|\s{2,}"));
      arr.removeRange(0, 2);
      String content = arr.map((e) => """<p>$e</p>""").join("\n");
      String html = getPageString(widget.name, chapterName, content, statusBarHeight, bottomBarHeight);
      final file = File("${docDir.path}/books/$aid/$cid.html");
      file.writeAsStringSync(html);
      fileUri.value = "file://${file.path}";
    }

    onPointerDown(PointerDownEvent event) {
      tapDownPos = event.position.dx;
    }

    onPointerMove(PointerMoveEvent event) {
      if (enableGestureListener.value) {
        webViewController.value!.scrollBy(x: (-event.delta.dx * extraRate).round(), y: 0);
      }
    }

    onPointerUp(PointerUpEvent event, WidgetRef ref) {
      if (!enableGestureListener.value) return;
      tapUpPos = event.position.dx;
      Log.d(tapUpPos, "tapUpPos");
      double res = (tapUpPos - tapDownPos);
      double resAbs = res.abs();
      Log.d(resAbs, "resAbs");
      Log.d(res, "res");
      if (resAbs > distance) {
        if (res < 0) {
          currentPage.value++;
        } else {
          currentPage.value--;
        }
      }
      webViewController.value!.scrollTo(x: (pageWidth * currentPage.value).round(), y: 0, animated: true);
    }

    useEffect(() {
      if (Platform.isAndroid) {
        extraRate = MediaQuery.of(context).devicePixelRatio;
      }
      statusBarHeight = padding.top;
      bottomBarHeight = padding.bottom;
      fetchCatalog(widget.aid);
      return () {};
    }, []);

    useEffect(() {
      var cv = chapters.value;
      if (cv.isNotEmpty) {
        chapters.value.take(3).forEach((element) {
          Log.d(element.json);
        });
        fetchContent(widget.aid, cv[0].cid, cv[0].name);
      }
      return () {};
    }, [chapters.value]);

    useEffect(() {
      var controller = webViewController.value;
      if (controller != null && fileUri.value != null) {
        Log.d(fileUri.value, "fv");
        controller.addJavaScriptHandler(
            handlerName: "notifySize",
            callback: (params) {
              pageWidth = params[0] * extraRate;
            });
        controller.addJavaScriptHandler(
            handlerName: "onBookReady",
            callback: (params) {
              loading.value = false;
            });
        controller.loadUrl(urlRequest: URLRequest(url: WebUri(fileUri.value!)));
      }
      return () {};
    }, [fileUri.value, webViewController.value]);

    return Material(
        child: Stack(
      children: [
        Listener(
            onPointerMove: onPointerMove,
            onPointerUp: (event) => onPointerUp(event, ref),
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
              initialSettings: InAppWebViewSettings(
                  pageZoom: 1,
                  userAgent: "ReaderJs/Client",
                  verticalScrollBarEnabled: false,
                  horizontalScrollBarEnabled: false,
                  disableHorizontalScroll: true,
                  disableVerticalScroll: true),
            )),
        loading.value
            ? Container(
                color: const Color(0xfff7f1e8),
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 42,
                  height: 42,
                  child: CircularProgressIndicator(),
                ))
            : const SizedBox.shrink()
      ],
    ));
  }
}
