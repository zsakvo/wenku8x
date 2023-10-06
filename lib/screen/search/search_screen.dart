import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/search/app_bar.dart';
import 'package:wenku8x/theme/extend.dart';

import 'book_item.dart';
import 'search_provider.dart';

class SearchScreen extends StatefulHookConsumerWidget {
  const SearchScreen({super.key, this.searchKey});
  final String? searchKey;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final search = ref.watch(searchProvider);
    useEffect(() {
      if (widget.searchKey != null) {
        Future(() {
          ref.read(searchProvider.notifier).init(widget.searchKey!);
        });
      }
      return null;
    }, []);
    return Scaffold(
      backgroundColor:
          Theme.of(context).extension<ExtendColors>()!.elevationBackground,
      appBar: SearchAppBar(searchKey: widget.searchKey),
      body: search.isLoading
          ? const Center(
              child: SizedBox(
                  width: 96, height: 3, child: LinearProgressIndicator()),
            )
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: search.names.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, bottom: 16),
                          child: Text(
                            "书名",
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                SliverList.builder(
                  itemBuilder: (context, index) {
                    final aid = search.names[index];
                    final key = GlobalKey();
                    return BookItemComp(
                      key: key,
                      aid,
                      onItemTap: (item) {
                        GoRouter.of(context).push("/detail", extra: item);
                      },
                    );
                  },
                  itemCount: search.names.length,
                ),
                SliverToBoxAdapter(
                  child: search.authors.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, bottom: 16),
                          child: Text(
                            "作者",
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                SliverList.builder(
                  itemBuilder: (context, index) {
                    final aid = search.authors[index];
                    final key = GlobalKey();
                    return BookItemComp(
                      key: key,
                      aid,
                      onItemTap: (item) {
                        GoRouter.of(context).push("/detail", extra: item);
                      },
                    );
                  },
                  itemCount: search.authors.length,
                ),
              ],
            ),
    );
  }
}
