import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/ui/components/top_bar.dart';
import 'package:wenku8x/app/utils/color.dart';
import 'package:wenku8x/discover/models/discover.dart';
import 'package:wenku8x/discover/providers/discover.dart';

import 'components/book_item.dart';

class DiscoverScreen extends StatefulHookConsumerWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(discoverFilterProvider);
    final books = ref.watch(discoverDataProvider);
    // final flags = useState<(String,String)>(("visit","allvisit"));
    // final rankType = useState<String>("visit");
    // final rankFlag = useState<String>("allvisit");
    // useEffect(() {
    //   final rank = novelSort[rankType.value];
    //   if (rank?["subs"] != null) {
    //     rankFlag.value =
    //         (rank?["subs"] as List<Map<String, dynamic>>).first["flag"];
    //   } else {
    //     rankFlag.value = rank?["flag"] as String;
    //   }
    //   return null;
    // }, [rankType]);

    return Scaffold(
      appBar: AppTopBar(title: "发现"),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Row(
                spacing: 6,
                children: [
                  PopupMenuButton<String>(
                    initialValue: filter.type,
                    onSelected: (String item) {
                      ref.read(discoverFilterProvider.notifier).setType(item);
                      // setState(() {
                      //   filter.setType(item);
                      //   final subs =
                      //       novelSort[item]?["subs"]
                      //           as List<Map<String, dynamic>>?;
                      //   if (subs != null) {
                      //     rankFlag.value = subs.first["flag"] as String;
                      //   }
                      // });
                    },
                    itemBuilder: (BuildContext context) =>
                        novelSort.entries.map((entry) {
                          return PopupMenuItem<String>(
                            value: entry.key,
                            child: Text(entry.value["title"] as String),
                          );
                        }).toList(),
                    // <PopupMenuEntry<Map<String, dynamic>>>
                    child: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      label: Text(novelSort[filter.type]?["title"] as String),
                    ),
                  ),

                  if (filter.flagName != null)
                    // OutlinedButton(
                    //   style: OutlinedButton.styleFrom(
                    //     minimumSize: Size(0, 32),
                    //     padding: EdgeInsets.only(left: 15, right: 15),
                    //     textStyle: TextStyle(fontSize: 13),
                    //   ),
                    //   onPressed: () {},
                    //   child: Text(
                    //     (novelSort[rankType.value]?["subs"]
                    //                 as List<Map<String, dynamic>>)
                    //             .firstWhereOrNull(
                    //               (e) => e["flag"] == rankFlag.value,
                    //             )?["title"]
                    //         as String,
                    //   ),
                    // ),
                    PopupMenuButton<String>(
                      borderRadius: BorderRadius.circular(30),
                      initialValue: filter.flag,
                      onSelected: (String item) {
                        // setState(() {
                        //   filter.setFlag(item);
                        // });
                        ref.read(discoverFilterProvider.notifier).setFlag(item);
                      },
                      itemBuilder: (BuildContext context) =>
                          (novelSort[filter.type]?["subs"]
                                  as List<Map<String, dynamic>>)
                              .map((entry) {
                                return PopupMenuItem<String>(
                                  value: entry["flag"] as String,
                                  child: Text(entry["title"] as String),
                                );
                              })
                              .toList(),
                      // <PopupMenuEntry<Map<String, dynamic>>>
                      child: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        label: Text(
                          (novelSort[filter.type]?["subs"]
                                      as List<Map<String, dynamic>>)
                                  .firstWhereOrNull(
                                    (e) => e["flag"] == filter.flag,
                                  )?["title"]
                              as String,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: switch (books) {
                AsyncData(:final value) => ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final book = value[index];
                    return BookItem(
                      book: book,
                      onTap: (book) {
                        context.push("/detail", extra: book);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(height: 16, thickness: 1);
                  },
                  itemCount: value.length,
                ),

                AsyncLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                _ => const Center(child: Text("暂无数据")),
              },
            ),
          ],
        ),
      ),
      // 使用 tabview 来切换榜单
      // Padding(
      //   padding: EdgeInsets.only(
      //     top: MediaQuery.of(context).padding.top,
      //     left: 8,
      //     right: 8,
      //   ),
      //   child: DefaultTabController(
      //     length: novelSort.entries.length,
      //     child: Column(
      //       children: [
      //         // TabBar
      //         TabBar(
      //           isScrollable: true,
      //           tabAlignment: TabAlignment.start,
      //           padding: const EdgeInsets.symmetric(horizontal: 0),
      //           dividerColor: Colors.transparent,
      //           indicatorPadding: EdgeInsets.only(bottom: 16),
      //           indicatorColor: Colors.transparent,
      //           labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      //           labelStyle: const TextStyle(
      //             fontSize: 16,
      //             fontWeight: FontWeight.w600,
      //           ),
      //           unselectedLabelStyle: const TextStyle(
      //             fontSize: 14,
      //             fontWeight: FontWeight.w400,
      //           ),
      //           tabs: novelSort.entries.map((sort) {
      //             return Tab(text: sort.value['title'] as String);
      //           }).toList(),
      //         ),
      //         // TabBarView
      //         Expanded(
      //           child: TabBarView(
      //             children: _rankings.map((category) {
      //               return ListView.builder(
      //                 padding: const EdgeInsets.all(16.0),
      //                 itemCount: category.books.length,
      //                 itemBuilder: (context, index) {
      //                   final book = category.books[index];
      //                   return Container(
      //                     color: generateColorFromString(book.title),
      //                   );
      //                 },
      //               );
      //             }).toList(),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

      // RefreshIndicator.adaptive(
      //   onRefresh: ref.read(discoverAllProvider.notifier).refresh,
      //   child: switch (discovers) {
      //     AsyncData(:final value) => ListView.builder(
      //       padding: const EdgeInsets.only(left: 16, right: 16),
      //       itemCount: value.length,
      //       itemBuilder: (context, index) {
      //         final ranking = value[index];
      //         return Padding(
      //           padding: const EdgeInsets.only(bottom: 16.0),
      //           child: _buildRankingSection(ranking),
      //         );
      //       },
      //     ),
      //     _ => const Center(child: Text("暂无数据")),
      //   },
      // ),
      // ListView.builder(
      //   padding: const EdgeInsets.all(16.0),
      //   itemCount: _rankings.length,
      //   itemBuilder: (context, index) {
      //     final ranking = _rankings[index];
      //     return Padding(
      //       padding: const EdgeInsets.only(bottom: 24.0),
      //       child: _buildRankingSection(ranking),
      //     );
      //   },
      // ),
    );
  }
}
