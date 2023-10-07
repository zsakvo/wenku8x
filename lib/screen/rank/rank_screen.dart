import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/rank/book_item.dart';
import 'package:wenku8x/screen/rank/rank_provider.dart';
import 'package:wenku8x/screen/rank/tab_bar.dart';
import 'package:wenku8x/theme/extend.dart';

class RankScreen extends StatefulHookConsumerWidget {
  const RankScreen(this.type, {super.key});
  final String type;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RankScreenState();
}

class _RankScreenState extends ConsumerState<RankScreen> {
  @override
  Widget build(BuildContext context) {
    EasyRefreshController controller = EasyRefreshController();
    final provider = rankProvider(widget.type);
    final rank = ref.watch(provider);
    return Scaffold(
        backgroundColor:
            Theme.of(context).extension<ExtendColors>()!.elevationBackground,
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor:
              Theme.of(context).extension<ExtendColors>()!.elevationBackground,
          title: Text(
            rank.title,
            style: const TextStyle(fontSize: 18),
          ),
          centerTitle: false,
          leading: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: SvgPicture.asset(
                "assets/svg/ic_search_bar_back.svg",
                width: 23,
                height: 23,
                // colorFilter: ColorFilter.mode(
                //     Theme.of(context).colorScheme.secondary,
                //     BlendMode.srcIn),
              )),
          actions: [
            IconButton(
                onPressed: () {
                  GoRouter.of(context).push("/search");
                },
                icon: SvgPicture.asset(
                  "assets/svg/ic_topbar_search.svg",
                  width: 23,
                  height: 23,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                ))
          ],
          bottom: rank.subs == null
              ? null
              : RankTabBar(
                  tabs: rank.subs!,
                  selectedIndex: rank.subIndex,
                  onTabChange: (flag) {
                    ref.read(provider.notifier).updateSub(flag);
                    controller.callRefresh(force: true);
                  },
                ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: EasyRefresh(
              controller: controller,
              refreshOnStart: true,
              onRefresh: ref.read(provider.notifier).init,
              onLoad: ref.read(provider.notifier).loadMore,
              child: CustomScrollView(slivers: [
                const HeaderLocator.sliver(),
                SliverList.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(top: index == 0 ? 10 : 0),
                        child: BookItemComp(
                          rank.books[index],
                          onItemTap: (item) {
                            GoRouter.of(context).push("/detail", extra: item);
                          },
                        ));
                  },
                  itemCount: rank.books.length,
                ),
                const FooterLocator.sliver(),
              ]),
            )));
  }
}
