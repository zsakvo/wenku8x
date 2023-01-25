// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/modals/current.dart';
import 'package:wenku8x/utils/log.dart';
import 'package:wenku8x/views/reader/reader_model.dart';

final webViewKey = GlobalKey();
late InAppWebViewController wController;

late BuildContext mContext;

int pageWidth = 0;
double mDensityFixedWidth = 0.0, mDensityFixedHeight = 0.0;
late ValueNotifier<int> currentPage;

onWebViewCreated(InAppWebViewController webViewController, BuildContext context, WidgetRef ref, String aid,
    ValueNotifier<int> page) async {
  wController = webViewController;
  currentPage = page;
  mContext = context;
  final fileUrl = await ref.watch(contentProvider(aid).future);
  initReader(fileUrl);
  mMargin[0] = MediaQuery.of(context).padding.top + 320;
  // wController.addJavaScriptHandler(
  //     handlerName: "NotifySize",
  //     callback: (params) {
  //       Log.d(params, "notifySize");
  //       ref.read(loadingStatusProvider.notifier).increase();
  //       setPageWidth(params);
  //     });
  wController.addJavaScriptHandler(
      handlerName: "onBookReady",
      callback: (params) {
        Log.d(params, "onBookReady");
        ref.read(loadingStatusProvider.notifier).toggle();
      });
}

initReader(String fileUrl) {
  wController.loadUrl(urlRequest: URLRequest(url: WebUri(fileUrl)));
}

onContentSizeChanged(controller, newSize, oldSize, WidgetRef ref) {
  Log.d("contentChanged");
  // Log.d("oncontentsizechange,$canShow");
  // if (canShow) {
  //   if (!loadNextCpt) {
  //     page.value = pages.value - 1;
  //     wController.scrollTo(x: (pageWidth * (pages.value - 1)).round(), y: 0);
  //   } else {
  //     wController.scrollTo(x: (pageWidth * (page.value)).round(), y: 0);
  //   }
  //   isLoading.value = false;
  //   canShow = false;
  // }
  // ref.read(loadingStatusProvider.notifier).increase();
}

bool gestureListener = true;
onPointerMove(PointerMoveEvent event) {
  if (gestureListener) {
    wController.scrollBy(
        x: (-event.delta.dx * (Platform.isIOS ? 1 : MediaQuery.of(mContext).devicePixelRatio)).round(), y: 0);
  }
}

// int page = 0;
const distance = 24;
double tapDownPos = 0.0;
onPointerDown(PointerDownEvent event) {
  tapDownPos = event.position.dx;
  Log.d(tapDownPos, "tapdown");
}

double tapUpPos = 0.0;
onPointerUp(PointerUpEvent event, WidgetRef ref) {
  final currentNotifier = ref.read(currentStatusProvider.notifier);
  if (!gestureListener) return;
  tapUpPos = event.position.dx;
  Log.d(tapUpPos, "tapUpPos");
  double res = (tapUpPos - tapDownPos);
  double resAbs = res.abs();
  // Log.d(res);
  if (resAbs > distance) {
    res < 0
        ?
        // currentNotifier.increasePage()
        currentPage.value++
        :
        // currentNotifier.decreasePage();
        currentPage.value--;
  }
  Current current = currentNotifier.state;
  Log.d(current, "zzz");
  Log.d("$pageWidth\n${current.page}", "???");
  wController.scrollTo(x: (pageWidth * currentPage.value).round(), y: 0, animated: true);
}

setPageWidth(params) {
  // loadTmp++;
  double pixelRatio = MediaQuery.of(mContext).devicePixelRatio;
  pageWidth = ((Platform.isIOS ? 1 : pixelRatio) * params[0]).round();
  final double notifyWidth = params[0] * 1.0;
  final double notifyHeight = params[1] * 1.0;
  final double mContentScaleX = notifyWidth / webViewKey.currentContext!.size!.width;
  final double mContentScaleY = notifyHeight / webViewKey.currentContext!.size!.height;
  mDensityFixedWidth = mContentScaleX * pixelRatio;
  mDensityFixedHeight = mContentScaleY * pixelRatio;
  // if (loadTmp == 1) {
  //   Future.delayed(const Duration(milliseconds: 300)).then((value) {
  //     isLoading.value = false;
  //     loadTmp = -1;
  //   });
  // }
}
