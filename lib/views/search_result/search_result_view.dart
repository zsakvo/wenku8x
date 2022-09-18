import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wenku8x/modals/book_meta.dart';
import 'package:wenku8x/views/search_result/search_result_model.dart';
import 'package:wenku8x/widgets/list_book.dart';

class SearchResultView extends StatefulHookConsumerWidget {
  final String keyword;
  const SearchResultView(this.keyword, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchResultViewState();
}

class _SearchResultViewState extends ConsumerState<SearchResultView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final List<BookMeta> bookList =
        ref.watch(searchListProvider(widget.keyword));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: colorScheme.surface,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            margin: EdgeInsets.only(
                left: 32.w, right: 32.w, top: 20.w, bottom: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.12),
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => GoRouter.of(context).pop(),
                    icon: const Icon(Icons.arrow_back)),
                Expanded(
                    child: Transform.translate(
                  offset: Offset(0, -1.w),
                  child: Text(
                    widget.keyword,
                    style: TextStyle(fontSize: 32.w),
                  ),
                )),
                IconButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.w),
            child: Text(
              "共 ${bookList.length} 条搜索结果",
              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: EasyRefresh(
                  refreshOnStart: true,
                  onRefresh: () {
                    ref
                        .read(searchListProvider(widget.keyword).notifier)
                        .search();
                  },
                  child: ListView.builder(
                    itemCount: bookList.length,
                    shrinkWrap: true,
                    itemExtent: 230.w,
                    itemBuilder: (context, index) {
                      var book = bookList[index];
                      return ListBookTile(context,
                          cover: book.cover,
                          name: book.title!,
                          desc1: "${book.author} / ${book.status}",
                          desc2: "最新章节：${book.latestSection}", onTap: () {
                        GoRouter.of(context).push("/book_detail/${book.aid}");
                      });
                    },
                  )))
        ],
      ),
    );
  }
}
