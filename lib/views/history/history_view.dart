import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/data/scheme/history_book.dart';
import 'package:wenku8x/widgets/list_book.dart';

import '../home/home_model.dart';

class HistoryView extends StatefulHookConsumerWidget {
  const HistoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryViewState();
}

class _HistoryViewState extends ConsumerState<HistoryView> {
  double top = 0.0;
  @override
  Widget build(BuildContext context) {
    final List<HistoryBook> booksList = ref.watch(historyBooksListProvider);
    return Scaffold(
      body: SafeArea(
          top: false,
          child: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                title: const Text("历史记录"),
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
                actions: [
                  IconButton(
                      onPressed: () {
                        ref.read(historyBooksListProvider).clear();
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                      ))
                ],
                flexibleSpace: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    title: Text(
                      "历史记录",
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
              const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
              SliverList(
                  delegate: SliverChildListDelegate(
                booksList
                    .map((book) => ListBookTile(context,
                            cover: book.cover,
                            name: book.bookName,
                            // desc1: "${book.author} / ${book.status}",
                            desc1: "上次更新：${book.updateTime}", onTap: () {
                          GoRouter.of(context).push("/book_detail/${book.aid}");
                        }))
                    .toList(),
              )),
            ],
          )),
    );
  }
}
