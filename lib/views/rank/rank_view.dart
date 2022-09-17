import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/modals/list_book.dart';
import 'package:wenku8x/utils/constant.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wenku8x/utils/log.dart';
import 'package:wenku8x/widgets/list_book.dart';

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
    Log.d(type);
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
          itemExtent: 230.w,
          itemCount: booksList.length,
          itemBuilder: (context, index) {
            ListBook book = booksList[index];
            return ListBookTile(context,
                cover: book.cover,
                name: book.title,
                desc1: "${book.author} / ${book.status}",
                desc2: "上次更新：${book.lastUpdate}", onTap: () {
              GoRouter.of(context).push("/book_detail/${book.aid}");
            });
          },
        ),
      ),
    );
  }
}
