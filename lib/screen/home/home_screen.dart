import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/home/add_modal.dart';
import 'package:wenku8x/screen/home/app_bar.dart';
import 'package:wenku8x/screen/home/detail_modal.dart';
import 'package:wenku8x/screen/home/home_provider.dart';
import 'package:wenku8x/theme/extend.dart';
import 'package:wenku8x/utils/flash.dart';

import 'book_item.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    EasyRefreshController controller = EasyRefreshController();
    var books = ref.watch<List<BookItem>>(myBooksProvider);
    return Scaffold(
        backgroundColor:
            Theme.of(context).extension<ExtendColors>()!.elevationBackground,
        appBar: HomeAppBar(
          onSearchTap: () {
            GoRouter.of(context).push("/search");
          },
          onAddTap: () {
            Show.pannel(
              context: context,
              builder: (context, controller) {
                return AddModal(controller);
              },
            );
          },
          onAvatarTap: () {
            GoRouter.of(context).push("/profile");
          },
        ),
        body: EasyRefresh(
            controller: controller,
            canLoadAfterNoMore: false,
            refreshOnStart: true,
            onRefresh: ref.read(myBooksProvider.notifier).refresh,
            child: CustomScrollView(
              slivers: [
                const HeaderLocator.sliver(),
                SliverList.builder(
                  itemBuilder: (context, index) {
                    final book = books[index];
                    final child = BookItemComp(book, onItemTap: (item) {
                      GoRouter.of(context)
                          .push("/reader/${item.name}/${item.aid}/-1");
                    }, onItemLongTap: (item) {
                      Show.pannel(
                        context: context,
                        builder: (context, controller) {
                          return DetailModal(controller, book);
                        },
                      );
                    });
                    return index == 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: child)
                        : child;
                  },
                  itemCount: books.length,
                ),
                const FooterLocator.sliver(),
              ],
            )));
  }
}
