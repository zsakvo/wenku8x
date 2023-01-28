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
  var top = 0.0;
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
      body: EasyRefresh(
          onRefresh: () => ref.read(booksListProvider.notifier).refresh(widget.type),
          onLoad: () => ref.read(booksListProvider.notifier).loadMore(widget.type),
          child: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                title: Text(RankMap[type]!),
                pinned: true,
                leading: Transform.translate(
                  offset: const Offset(0, 2),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                flexibleSpace: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    title: Text(
                      RankMap[type]!,
                      style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
                    ),
                    centerTitle: false,
                    titlePadding: EdgeInsetsDirectional.only(
                      start: top > 140 ? 16.0 : 56,
                      bottom: 16.0,
                    ),
                  );
                }),
              ),
              const HeaderLocator.sliver(),
              const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
              SliverList(
                  delegate: SliverChildListDelegate(
                booksList
                    .map((book) => ListBookTile(context,
                            cover: book.cover,
                            name: book.title,
                            desc1: "${book.author} / ${book.status}",
                            desc2: "上次更新：${book.lastUpdate}", onTap: () {
                          GoRouter.of(context).push("/book_detail/${book.aid}");
                        }))
                    .toList(),
              )),
              const FooterLocator.sliver(),
            ],
          )),
    );
  }
}
