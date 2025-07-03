import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/ui/components/top_bar.dart';
import 'package:wenku8x/search/providers/search.dart';

class SearchScreen extends StatefulHookConsumerWidget {
  const SearchScreen({super.key, required this.searchKey});

  final String searchKey;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchData = ref.watch(searchFilterProvider(widget.searchKey));
    return Scaffold(
      appBar: AppTopBar(title: "搜索: ${widget.searchKey}"),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            constraints: BoxConstraints.expand(height: 36),
            child: CustomSlidingSegmentedControl<SearchType>(
              initialValue: SearchType.name,
              isStretch: true,
              children: const {
                SearchType.name: Text('书名', textAlign: TextAlign.center),
                SearchType.author: Text('作者', textAlign: TextAlign.center),
              },
              innerPadding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(30),
              ),
              thumbDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              onValueChanged: (v) {
                print(v);
              },
            ),
          ),
        ],
      ),
    );
  }
}
