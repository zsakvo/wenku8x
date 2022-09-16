import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wenku8x/modals/book_meta.dart';
import 'package:wenku8x/utils/log.dart';

import 'book_detail_model.dart';

class BookDetailView extends StatefulHookConsumerWidget {
  final String aid;
  const BookDetailView(this.aid, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends ConsumerState<BookDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<BookMeta> meta = ref.watch(bookMetaProvider(widget.aid));
    final appBarTitle = ref.watch(appBarTitleProvider);
    final scrollController = useScrollController(keepScrollOffset: true);
    scrollController.addListener(() {
      double pos = scrollController.position.pixels;
      if (pos > 100) {
        ref.read(appBarTitleProvider.notifier).setTitle("2333");
      } else {
        ref.read(appBarTitleProvider.notifier).setTitle("");
      }
    });
    return meta.when(
      data: (meta) {
        return Material(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                  floating: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 40.sp,
                    ),
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                  ),
                  actions: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                  ],
                  centerTitle: false,
                  title: Transform.translate(
                      offset: Offset(0, -2.sp),
                      child: Text(
                        appBarTitle,
                        style: TextStyle(fontSize: 32.sp),
                      ))),
              SliverToBoxAdapter(
                child: Container(
                  height: 5000,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        );
        // return Scaffold(
        //   appBar: AppBar(
        //       leading: IconButton(
        //         icon: Icon(
        //           Icons.arrow_back,
        //           size: 40.sp,
        //         ),
        //         onPressed: () {
        //           GoRouter.of(context).pop();
        //         },
        //       ),
        //       actions: [
        //         IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        //       ],
        //       centerTitle: false,
        //       title: Transform.translate(
        //           offset: Offset(0, -2.sp),
        //           child: Text(
        //             meta.title!,
        //             style: TextStyle(fontSize: 32.sp),
        //           ))),
        //   body: Column(
        //       children: [Text(meta.author ?? ""), Text(meta.intro ?? "")]),
        // );
      },
      error: (err, stack) => Material(
        child: Container(
          alignment: Alignment.center,
          child: Text('Error: $err'),
        ),
      ),
      loading: () => Material(
        child: Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 84.w,
              height: 84.w,
              child: const CircularProgressIndicator(),
            )),
      ),
    );
  }
}
