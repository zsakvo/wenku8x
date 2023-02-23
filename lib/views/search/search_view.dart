import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchView extends StatefulHookConsumerWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.4),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        title: TextField(
          autofocus: true,
          controller: searchController,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                  },
                  icon: const Icon(Icons.clear)),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: "搜索书籍或作者"),
          onSubmitted: (value) {
            GoRouter.of(context).push("/search_result/$value");
          },
        ),
      ),
    );
  }
}
