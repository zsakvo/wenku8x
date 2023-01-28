import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    statusBarHeight = padding.top;
    bottomBarHeight = padding.bottom;
    useEffect(() {
      return () {};
    }, []);
    return Material(
        child: Stack(
      children: [
        Listener(
            // onPointerMove: onPointerMove,
            // onPointerUp: (event) => onPointerUp(event, ref),
            // onPointerDown: onPointerDown,
            behavior: HitTestBehavior.translucent,
            child: InAppWebView(
              key: webViewKey,
              onWebViewCreated: (c) => onWebViewCreated(c, context, ref, widget.aid),
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
