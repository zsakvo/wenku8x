import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/modals/chapter.dart';
import 'package:wenku8x/utils/log.dart';
import 'package:wenku8x/views/reader/reader_model.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../current.dart';

class ReaderView extends StatefulHookConsumerWidget {
  final String aid;
  const ReaderView(this.aid, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReaderViewState();
}

class _ReaderViewState extends ConsumerState<ReaderView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    ref.listen<Current>(currentProvider, (Current? oldValue, Current newValue) {
      currentListener(oldValue, newValue, this, ref);
    });
    final AsyncValue<List<Chapter>> catalog =
        ref.watch(catalogProvider(widget.aid));
    final List<dynamic> chapters = ref.watch(chaptersProvider);
    Log.d("重构了哦");
    return Material(
        child: catalog.when(
      data: (data) {
        // ref.watch(readerProvider(this));
        return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapUp: ((details) {
              onPageTap(details, context, ref);
            }),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
                ...(chapters.map((chapter) {
                  var textWidget = chapter["text"];
                  // AnimationController controller = chapter["ctrl"];
                  return textWidget;
                }).toList()),
              ],
            ));
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => Container(
          alignment: Alignment.center,
          child: SizedBox(
            width: 84.w,
            height: 84.w,
            child: const CircularProgressIndicator(),
          )),
    ));
  }
}
