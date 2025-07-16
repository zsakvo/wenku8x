import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:wenku8x/app/providers/user.dart';
import 'package:wenku8x/app/ui/components/top_bar.dart';
import 'package:wenku8x/app/ui/components/user_avatar.dart';
import 'package:wenku8x/shelf/providers/books.dart';
import 'package:wenku8x/shelf/ui/components/book_item.dart';

class ShelfScreen extends StatefulHookConsumerWidget {
  const ShelfScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShelfScreenState();
}

class _ShelfScreenState extends ConsumerState<ShelfScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final controller = useSearchController();
    // final books = ref.watch(bookProviderProvider);
    // final userId = ref.watch(userProvider.select((value) => value.asData?.value.));
    final books = ref.watch(booksProvider);
    return Scaffold(
      appBar: AppTopBar(
        title: UserAvatar(),
        canPop: false,
        titleLeftPadding: 20,
        actions: [
          SearchAnchor(
            builder: (context, controller) {
              return IconButton(
                onPressed: () {
                  // context.push("/search", extra: "我的");
                  controller.openView();
                },
                icon: SvgPicture.asset(
                  "assets/svg/ic_topbar_search.svg",
                  colorFilter: ColorFilter.mode(
                    colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                  width: 22,
                ),
              );
            },
            headerHeight: 56,
            viewLeading: IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                backgroundColor: WidgetStateProperty.all(
                  colorScheme.inverseSurface.withAlpha(20),
                ),
                minimumSize: WidgetStateProperty.all(const Size(32, 32)),
                maximumSize: WidgetStateProperty.all(const Size(32, 32)),
              ),
              icon: const Icon(CupertinoIcons.back, size: 20),
              onPressed: () {
                context.pop();
              },
            ),
            viewHintText: "搜索书名或作者",
            suggestionsBuilder: (context, controller) {
              return [];
            },
            viewOnSubmitted: (value) {
              if (value.isNotEmpty) {
                controller.closeView(value);
                controller.clear();
                context.push("/search", extra: value);
              }
            },
            searchController: controller,
          ),
          // IconButton(
          //   onPressed: () {
          //     context.push("/search", extra: "我的");
          //   },
          //   icon: SvgPicture.asset(
          //     "assets/svg/ic_topbar_search.svg",
          //     colorFilter: ColorFilter.mode(
          //       colorScheme.onSurface,
          //       BlendMode.srcIn,
          //     ),
          //     width: 22,
          //   ),
          // ),
          IconButton(
            onPressed: () {
              // context.push("/preference");
              // BookSourceService().lsitAll();
              // BookSourceService().action(uuid: 'bd406921-c0b5-48f0-9462-8e0242d32e3f', act: "test");
            },
            icon: SvgPicture.asset(
              "assets/svg/ic_topbar_more.svg",
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ),
              width: 22,
            ),
          ),
        ],
      ),
      // body: CustomScrollView(
      //   slivers: [
      //     SliverPadding(
      //       padding: EdgeInsets.only(left: 0, right: 0, bottom: 20, top: 4),
      //       sliver: SliverToBoxAdapter(
      //         child: LastRead(),
      //         // child: ShelfSwitcher(),
      //       ),
      //     ),
      //     SliverToBoxAdapter(
      //       child: switch (books) {
      //         AsyncValue(:final value?) => ShelfGrid(
      //             books: value,
      //           ),
      //         _ => ShelfGrid(books: [])
      //       },
      //       // child: ShelfSwitcher(),
      //     ),
      //   ],
      // ),
      body: RefreshIndicator.adaptive(
        onRefresh: ref.read(booksProvider.notifier).refresh,
        child: switch (books) {
          AsyncValue(:final value, hasValue: true) => ListView.separated(
            itemCount: value!.length,
            cacheExtent: 128,
            itemBuilder: (context, index) {
              final book = value[index];
              return BookItem(
                book: book,
                onTap: (book) {
                  context.push("/reader", extra: book);
                },
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 0);
            },
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}
