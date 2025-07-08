import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PointerService {
  static final PointerService _instance = PointerService._internal();

  factory PointerService() {
    return _instance;
  }

  PointerService._internal();

  late WidgetRef ref;
  double pointerDownPosX = 0.0;

  init(WidgetRef widgetRef) {
    ref = widgetRef;
  }

  void onPointerDown(PointerDownEvent event) {
    pointerDownPosX = event.position.dx;
    // pointDownPage = pageController.page!.round();
  }

  void onPointerMove(PointerMoveEvent event) {
    // Handle pointer move events
    //   if (ref.read(readerMenuStateProvider).subMenusVisible) {
    //   return;
    // }
    // if (ref.read(readerMenuStateProvider).parentMenuVisible) {
    //   return;
    // }
    // // Log.e(event.delta.dx);
    // // 当移动距离 posX 大于 5 个像素的时候开始跟随
    // final dx = event.position.dx - posX;
    // if (dx.abs() > 5) {
    //   // 最后一章和第一章禁止额外滚动
    //   double offset = pageController.offset - event.delta.dx;
    //   if (offset <= 0) {
    //     offset = 0;
    //   } else {
    //     offset = offset > pageController.position.maxScrollExtent
    //         ? pageController.position.maxScrollExtent
    //         : offset;
    //   }
    //   pageController.jumpTo(offset);
    // }
  }

  void onPointerUp(PointerUpEvent event) {
    // Handle pointer up events
  }
}
