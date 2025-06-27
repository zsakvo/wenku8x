import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/ui/components/top_bar.dart';

class ShelfScreen extends StatefulHookConsumerWidget {
  const ShelfScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShelfScreenState();
}

class _ShelfScreenState extends ConsumerState<ShelfScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // final books = ref.watch(bookProviderProvider);
    return Scaffold(
      appBar: AppTopBar(
        title: ClipOval(
          child: CachedNetworkImage(
            imageUrl: "https://avatars.githubusercontent.com/u/25399519?v=4",
            width: 32,
          ),
        ),
        canPop: false,
        titleLeftPadding: 20,
        actions: [
          IconButton(
            onPressed: () {
              context.push("/search");
            },
            icon: SvgPicture.asset(
              "assets/svg/ic_topbar_search.svg",
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ),
              width: 22,
            ),
          ),
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
    );
  }
}
