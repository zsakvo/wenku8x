import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/providers/download_provider.dart';

import 'package:wenku8x/screen/detail/detail_provider.dart';
import 'package:wenku8x/screen/home/home_provider.dart';
import 'package:wenku8x/theme/extend.dart';
import 'package:wenku8x/utils/flash.dart';

class DetailScreen extends StatefulHookConsumerWidget {
  const DetailScreen(this.bookItem, {super.key});
  final BookItem bookItem;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final bookItem = widget.bookItem;
    final detail = ref.watch(detailProvider(bookItem));
    final catalog = detail.catalog;
    final showAppBarTitle = useState(false);
    final showExtendFab = useState(true);
    final scrollController = useScrollController(keepScrollOffset: true);
    final myBooks = ref.watch(myBooksProvider);

    final provider = bookDownloaderProvider(bookItem.aid);
    final downloader = ref.watch(provider);
    final downloadProgress = useFuture(
        useMemoized(() async {
          final progress = await downloader.progress;
          if (progress == '缓存') {
            return "缓存章节";
          } else {
            return progress;
          }
        }, [downloader]),
        initialData: "缓存章节");

    final isFav = useMemoized(() {
      return myBooks.any((element) => element.aid == bookItem.aid);
    }, [myBooks]);

    useEffect(() {
      listener() {
        double pos = scrollController.position.pixels;
        showAppBarTitle.value = pos > 96.0;
        showExtendFab.value = scrollController.position.userScrollDirection ==
            ScrollDirection.forward;
      }

      scrollController.addListener(listener);
      return () {
        scrollController.removeListener(listener);
      };
    }, [scrollController]);
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor:
            Theme.of(context).extension<ExtendColors>()!.elevationBackground,
        body: detail.intro == null
            ? const Center(
                child: SizedBox(
                    width: 96, height: 3, child: LinearProgressIndicator()),
              )
            : CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    titleSpacing: 0,
                    elevation: 1.0,
                    scrolledUnderElevation: 1.0,
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
                    backgroundColor: Theme.of(context)
                        .extension<ExtendColors>()!
                        .elevationBackground,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: IconButton.filledTonal(
                            onPressed: () {
                              GoRouter.of(context)
                                  .push("/search", extra: detail.author);
                            },
                            icon: SvgPicture.asset(
                              "assets/svg/ic_topbar_person_search.svg",
                              width: 22,
                            )),
                      )
                    ],
                    title: Text(
                      detail.name,
                      style: TextStyle(
                          fontSize: 18,
                          color: showAppBarTitle.value
                              ? Theme.of(context).colorScheme.onBackground
                              : Colors.transparent),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: detail.cover!,
                            width: 98,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                              child: Container(
                            height: 140,
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    detail.name,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontSize: 18),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Text(
                                      "${detail.author!}\t/\t${detail.status!}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    "更新时间：${detail.lastUpdate!}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 14),
                                  ),
                                ]),
                          ))
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    sliver: SliverToBoxAdapter(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            isFav
                                ? ref
                                    .read(myBooksProvider.notifier)
                                    .delBook(detail.aid)
                                : ref
                                    .read(myBooksProvider.notifier)
                                    .addBook(detail);
                          },
                          child: Column(children: [
                            SvgPicture.asset(
                              isFav
                                  ? "assets/svg/ic_btn_like.svg"
                                  : "assets/svg/ic_btn_like_line.svg",
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.7),
                                  BlendMode.srcIn),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                isFav ? "已在书架" : "加入书架",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.7)),
                              ),
                            )
                          ]),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Show.error("尚未开放此功能");
                          },
                          child: Column(children: [
                            SvgPicture.asset(
                              "assets/svg/ic_btn_share.svg",
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.secondary,
                                  BlendMode.srcIn),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "分享本书",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            )
                          ]),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            ref.read(provider.notifier).download(bookItem.aid);
                          },
                          child: Column(children: [
                            SvgPicture.asset(
                              "assets/svg/ic_btn_download.svg",
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.secondary,
                                  BlendMode.srcIn),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                downloadProgress.data!,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            )
                          ]),
                        )
                      ],
                    )),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    sliver: SliverToBoxAdapter(
                        child: Divider(
                      height: 2,
                      thickness: 1.4,
                      endIndent: MediaQuery.of(context).size.width * 2 / 3,
                    )),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    sliver: SliverToBoxAdapter(child: Text(detail.intro!)),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    sliver: SliverToBoxAdapter(
                        child: Divider(
                      height: 2,
                      thickness: 1.4,
                      indent: MediaQuery.of(context).size.width * 2 / 3,
                    )),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    sliver: SliverToBoxAdapter(
                        child: Text(
                      "目录：共${detail.catalog!.length}章",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onBackground),
                    )),
                  ),
                  SliverList.builder(
                    itemBuilder: (context, index) {
                      final chapter = catalog[index];
                      return InkWell(
                        onTap: () {
                          // ref
                          //     .read(homeProvider.notifier)
                          //     .jumpToIndex(bookItem, index);
                          GoRouter.of(context).push(
                              "/reader/${detail.name}/${detail.aid}/$index");
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chapter.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontSize: 16),
                                ),
                                Text(
                                  "cid-${chapter.cid}",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 12),
                                )
                              ],
                            )),
                      );
                    },
                    itemCount: catalog!.length,
                  )
                ],
              ),
        floatingActionButton: detail.intro == null
            ? null
            : FloatingActionButton.extended(
                onPressed: () {
                  GoRouter.of(context)
                      .push("/reader/${detail.name}/${detail.aid}/-1");
                },
                label: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: showExtendFab.value ? 94 : 24,
                  child: showExtendFab.value
                      ? Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/ic_btn_read.svg",
                              width: 20,
                            ),
                            const Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                "开始阅读",
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                              ),
                            ))
                          ],
                        )
                      : SvgPicture.asset(
                          "assets/svg/ic_btn_read.svg",
                          width: 20,
                        ),
                )));
  }
}
