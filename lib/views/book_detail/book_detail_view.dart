import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wenku8x/modals/book_meta.dart';

import '../../modals/chapter.dart';
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
    final AsyncValue<List<Chapter>> catalog =
        ref.watch(catalogProvider(widget.aid));
    final appBarTitle = ref.watch(appBarTitleProvider);
    final scrollController = useScrollController(keepScrollOffset: true);
    scrollController.addListener(() {
      double pos = scrollController.position.pixels;
      ref.read(appBarTitleProvider.notifier).setTitle(pos <= 50.w);
    });
    return meta.when(
      data: (meta) {
        return Scaffold(
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                  pinned: true,
                  leading: Transform.translate(
                    offset: const Offset(0, 2),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                    ),
                  ),
                  actions: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                  ],
                  centerTitle: false,
                  title: Text(
                    appBarTitle,
                    style: TextStyle(fontSize: 32.sp),
                  )),
              SliverToBoxAdapter(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 40.w),
                child: Row(children: [
                  CachedNetworkImage(
                    imageUrl: meta.cover,
                    width: 160.w,
                    height: 220.w,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                      child: Container(
                    height: 240.w,
                    padding: EdgeInsets.only(left: 40.w),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              meta.title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 36.sp),
                            ),
                          ),
                          Text(
                            meta.author!,
                            style: TextStyle(
                                fontSize: 25.sp,
                                height: 1.6,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.7)),
                          ),
                          Text(meta.pressValue!,
                              style: TextStyle(
                                  fontSize: 25.sp,
                                  height: 1.6,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.7))),
                          Text("${meta.status!} / ${meta.bookLength!}字",
                              style: TextStyle(
                                  fontSize: 25.sp,
                                  height: 1.6,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.7))),
                        ]),
                  ))
                ]),
              )),
              SliverToBoxAdapter(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 26.w),
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  minimumSize: Size(124.w, 64.w),
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outline
                                          .withOpacity(0.5),
                                      width: 0.8)),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: Icon(
                                      Icons.favorite_border,
                                      size: 32.sp,
                                    ),
                                  ),
                                  Transform.translate(
                                      offset: Offset(0, -2.w),
                                      child: Text(
                                        "添加至书架",
                                        style: TextStyle(fontSize: 26.sp),
                                      ))
                                ],
                              )),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.public,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share,
                              color: Theme.of(context).colorScheme.primary,
                            ))
                      ],
                    )),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.w),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "书籍简介\n",
                        style: TextStyle(
                            fontSize: 40.sp,
                            height: 1,
                            color: Theme.of(context).colorScheme.onBackground)),
                    WidgetSpan(
                        child: SizedBox(
                      height: 56.w,
                    )),
                    TextSpan(
                        text: meta.intro,
                        style: TextStyle(
                            fontSize: 28.sp,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.7)))
                  ])),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 24.w, horizontal: 40.w),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            minimumSize: Size(double.infinity, 80.w)),
                        onPressed: () async {},
                        child: Text(
                          "开始阅读",
                          style: TextStyle(
                              fontSize: 26.sp,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ))),
              ),
              catalog.when(
                  data: (data) {
                    return SliverFixedExtentList(
                        delegate: SliverChildBuilderDelegate(
                          (_, index) => index == 0
                              ? ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 40.w),
                                  title: Text(
                                    "共 ${data.length} 章",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                  shape: Border(
                                    bottom: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline
                                            .withOpacity(0.1),
                                        width: 0.5),
                                  ),
                                )
                              : ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 40.w),
                                  title: Text(
                                    data[index - 1].name,
                                    style: TextStyle(fontSize: 26.sp),
                                  ),
                                  trailing: const Icon(Icons.cloud_outlined),
                                  shape: Border(
                                    bottom: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline
                                            .withOpacity(0.1),
                                        width: 0.5),
                                  ),
                                ),
                          childCount: data.length + 1,
                        ),
                        itemExtent: 104.w);
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator()),
              SliverToBoxAdapter(
                child: SizedBox(height: MediaQuery.of(context).padding.bottom),
              )
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
