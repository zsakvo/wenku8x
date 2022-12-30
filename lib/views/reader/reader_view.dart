import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/modals/current.dart';
import 'package:wenku8x/views/reader/reader_model.dart';

import 'webview.dart';

class ReaderView extends StatefulHookConsumerWidget {
  final String aid;
  const ReaderView({required this.aid, Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReaderViewState();
}

class _ReaderViewState extends ConsumerState<ReaderView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    useEffect(() {
      mMargin = [padding.top + 40, 18];
      return () {};
    }, []);
    bool loading = ref.watch(loadingStatusProvider);
    var currentPage = useState(0);
    return Material(
        child: Stack(
      children: [
        Listener(
            onPointerMove: onPointerMove,
            onPointerUp: (event) => onPointerUp(event, ref),
            onPointerDown: onPointerDown,
            behavior: HitTestBehavior.translucent,
            child: InAppWebView(
              key: webViewKey,
              onWebViewCreated: (c) => onWebViewCreated(c, context, ref, widget.aid, currentPage),
              onContentSizeChanged: (controller, newSize, oldSize) =>
                  onContentSizeChanged(controller, newSize, oldSize, ref),
              gestureRecognizers: {
                Factory<OneSequenceGestureRecognizer>(
                  () => LongPressGestureRecognizer(),
                )
              },
              initialSettings: InAppWebViewSettings(
                  pageZoom: 1,
                  verticalScrollBarEnabled: false,
                  horizontalScrollBarEnabled: false,
                  disableHorizontalScroll: true,
                  disableVerticalScroll: true),
            )),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40 + MediaQuery.of(context).viewPadding.top,
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, left: 18, right: 18),
            child: Row(children: [
              Text(
                "测试书名",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4), fontSize: 14),
              )
            ]),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).viewPadding.bottom,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Row(
              children: [
                const Spacer(),
                Text(
                  "${currentPage.value + 1}",
                  style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4), fontSize: 14),
                )
              ],
            ),
          ),
        ),
        loading
            ? Container(
                color: const Color(0xffE0CE9D),
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
