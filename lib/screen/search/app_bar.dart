import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/search/search_provider.dart';
import 'package:wenku8x/service/navigation.dart';

class SearchAppBar extends StatefulHookConsumerWidget
    implements PreferredSizeWidget {
  const SearchAppBar({super.key, this.searchKey});
  final String? searchKey;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(71);
}

class _SearchAppBarState extends ConsumerState<SearchAppBar> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    final searchController = useTextEditingController(text: widget.searchKey);
    final showSuffixIcon = useState(false);

    useEffect(() {
      searchController.addListener(() {
        if (searchController.text.isNotEmpty) {
          showSuffixIcon.value = true;
        } else {
          showSuffixIcon.value = false;
        }
      });
      return () {};
    }, [searchController]);
    return SafeArea(
        child: Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 42,
                        // padding: const EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: colorScheme.surfaceVariant.withOpacity(0.5)),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  GoRouter.of(context).pop();
                                },
                                icon: SvgPicture.asset(
                                  "assets/svg/ic_search_bar_back.svg",
                                  width: 23,
                                  height: 23,
                                  colorFilter: ColorFilter.mode(
                                      colorScheme.secondary, BlendMode.srcIn),
                                )),
                            Expanded(
                                child: TextField(
                              cursorHeight: 15,
                              autofocus: widget.searchKey == null,
                              controller: searchController,
                              cursorColor: Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.6),
                              style:
                                  const TextStyle(fontSize: 14, height: 1.10),
                              decoration: InputDecoration(
                                  isDense: true,
                                  suffixIcon: showSuffixIcon.value
                                      ? IconButton(
                                          onPressed: searchController.clear,
                                          icon: const Icon(Icons.clear),
                                        )
                                      : null,
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.4)),
                                  hintText: '搜索书名或作者',
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0)),
                              onSubmitted: (value) {
                                if (value.isEmpty) return;
                                ref.read(searchProvider.notifier).init(value);
                                // Future(() {
                                //   ref.read(topbarStateProvider.notifier).go(TopBarState(
                                //       showBack: true,
                                //       title: "搜索：$value",
                                //       key: "/search"));
                                // });
                              },
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Divider(
                    color: colorScheme.secondary.withOpacity(0.05),
                    height: 1,
                  ),
                )
              ],
            )));
  }
}
