import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/modals/list_book.dart';
import 'package:wenku8x/utils/constant.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'rank_model.dart';

class RankView extends StatefulHookConsumerWidget {
  final String type;
  const RankView(this.type, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RankViewState();
}

class _RankViewState extends ConsumerState<RankView> {
  @override
  void initState() {
    super.initState();
    ref.read(booksListProvider.notifier).refresh(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    final type = widget.type;
    final List<ListBook> booksList = ref.watch(booksListProvider);

    return Scaffold(
      appBar: AppBar(
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
                RankMap[type]!,
                style: TextStyle(fontSize: 32.sp),
              ))),
      body: EasyRefresh(
        onRefresh: () =>
            ref.read(booksListProvider.notifier).refresh(widget.type),
        onLoad: () =>
            ref.read(booksListProvider.notifier).loadMore(widget.type),
        child: ListView.builder(
          itemCount: booksList.length,
          itemBuilder: (context, index) {
            ListBook book = booksList[index];
            return InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
                child: Row(children: [
                  CachedNetworkImage(
                    imageUrl: book.cover,
                    width: 64,
                    height: 86,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                      child: Container(
                    height: 92,
                    padding: const EdgeInsets.only(left: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          book.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 28.sp,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                        Text(
                          "上次更新：${book.lastUpdate}\n${book.author} / ${book.status}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 22.sp,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.5)),
                        )
                      ],
                    ),
                  ))
                ]),
              ),
              onTap: () {
                GoRouter.of(context).push("/book_detail/${book.aid}");
              },
            );
          },
        ),
      ),
    );
  }
}
