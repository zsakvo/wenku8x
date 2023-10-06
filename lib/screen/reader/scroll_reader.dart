import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:wenku8x/utils/log.dart';

class ScrollReader extends StatefulHookConsumerWidget {
  const ScrollReader(this.pages, this.controller,
      {super.key, required this.loadNext, required this.onPageScrollEnd});
  final List<Widget> pages;
  final PageController controller;
  final Function() loadNext;
  final Function() onPageScrollEnd;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScrollReaderState();
}

class _ScrollReaderState extends ConsumerState<ScrollReader>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    onPageChanged(value) {
      if (value == widget.pages.length - 3) {
        Log.e("load next chapter");
        widget.loadNext();
      }
    }

    return Material(
        child: NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0 && notification is ScrollEndNotification) {
          // onPageChanged(widget.controller.page!.round());
          // var ok =
          //     (widget.pages[widget.controller.page!.round()].key as ValueKey)
          //         .value;
          // Log.e(ok);
          // if (widget.controller.page!.round() == widget.pages.length - 1) {
          widget.onPageScrollEnd();
          // }
        }
        return false;
      },
      child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          pageSnapping: false,
          controller: widget.controller,
          onPageChanged: onPageChanged,
          itemBuilder: (context, index) {
            return widget.pages[index];
          },
          itemCount: widget.pages.length),
    ));
  }
}
