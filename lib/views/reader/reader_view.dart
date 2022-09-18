import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/modals/chapter.dart';
import 'package:wenku8x/views/reader/reader_model.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final AsyncValue<List<Chapter>> catalog =
        ref.watch(catalogProvider(widget.aid));
    return Material(
        child: catalog.when(
      data: (data) {
        final AsyncValue<List<Widget>> content =
            ref.watch(readerProvider(this));
        return content.when(
            data: (data) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    ...data,
                  ],
                ),
                onTapUp: (detail) {
                  // Log.d(detail);
                  onPageTap(detail, context, ref);
                },
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 84.w,
                  height: 84.w,
                  child: const CircularProgressIndicator(),
                )));
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
