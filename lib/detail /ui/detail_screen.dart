import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/services/variable.dart';
import 'package:wenku8x/app/ui/components/top_bar.dart';
import 'package:wenku8x/app/utils/string.dart';
import 'package:wenku8x/detail%20/providers/detail.dart';

class DetailScreen extends StatefulHookConsumerWidget {
  const DetailScreen({super.key, required this.book});

  final BookModel book;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  final logger = Logger("DetailScreen");
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(detailProvider(widget.book));
    final bookDetail = data.asData?.value;
    return Scaffold(
      appBar: AppTopBar(title: "书籍详情"),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Skeletonizer(
                enabled: data.isLoading,
                ignoreContainers: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(
                        // "书籍ID:${widget.book.aid}\t\t|\t\t当前状态:${bookDetail?.status}",
                        "书籍ID:${widget.book.aid}\t\t|\t\t共${formatNumberToUnitString(bookDetail?.length ?? 0)}字",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(164),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: DottedBorder(
                        options: RectDottedBorderOptions(
                          padding: EdgeInsets.all(8),
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(100),
                          dashPattern: [4, 2],
                        ),
                        // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        // padding: EdgeInsets.all(8),
                        // decoration: BoxDecoration(
                        //   // 虚线边框
                        //   border: Border.all(
                        //     color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                        //     width: 1,
                        //   ),
                        // ),
                        child: Row(
                          spacing: 10,
                          children: [
                            bookDetail?.coverUrl == null
                                ? Container(
                                    width: 56,
                                    height: 82,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withAlpha(50),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: data.asData!.value.coverUrl,
                                    width: 56,
                                    height: 82,
                                    fit: BoxFit.cover,
                                    httpHeaders: {
                                      "User-Agent": VariableService().UserAgent,
                                    },
                                  ),
                            Expanded(
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bookDetail?.name ?? "这是一串用来撑开书名骨架屏的占位文本",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                            Icons.face,
                                            size: 15,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.tertiary,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "\t\t${bookDetail?.author}\t\t|\t\t${bookDetail?.pressName}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            height: 1,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.tertiary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: EdgeInsets.only(left: 12, right: 12, top: 14),
                    //   child: Row(
                    //     spacing: 14,
                    //     children: [
                    //       FilledButton.icon(
                    //         style: FilledButton.styleFrom(
                    //           minimumSize: Size(0, 32),
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(4),
                    //           ),
                    //         ),
                    //         onPressed: () {},
                    //         label: Text("开始阅读"),
                    //       ),
                    //       TextButton.icon(
                    //         icon: Icon(
                    //           Icons.add,
                    //           size: 16,
                    //           color: Theme.of(context).colorScheme.onSurface,
                    //         ),
                    //         style: TextButton.styleFrom(
                    //           minimumSize: Size(0, 32),
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(4),
                    //           ),
                    //           textStyle: TextStyle(
                    //             color: Theme.of(context).colorScheme.primary,
                    //           ),
                    //         ),
                    //         onPressed: () {},
                    //         label: Text("加入书架"),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 20,
                        bottom: 8,
                      ),
                      child: Text(
                        // "最新章节：${bookDetail?.lastUpdate}\t\t|\t\t${bookDetail?.lastChapter}",
                        "点击: ${bookDetail?.totalHitsCount}\t\t|\t\t收藏: ${bookDetail?.favCount}\t\t|\t\t推荐: ${bookDetail?.pushCount}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(164),
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 96,
                        minWidth: double.infinity,
                      ),
                      child: Card.filled(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        margin: EdgeInsets.only(left: 12, right: 12, bottom: 4),
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            spacing: 12,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 8,
                                children: [
                                  Text(
                                    "最新章节",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainerLowest
                                          .withAlpha(250),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      "${bookDetail?.status}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.normal,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface.withAlpha(200),
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.list_alt,
                                              size: 16,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "\t查看目录",
                                            style: TextStyle(
                                              fontSize: 12,
                                              height: 1,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "上次更新：${bookDetail?.lastUpdate}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface.withAlpha(200),
                                      ),
                                    ),
                                    TextSpan(text: "\n"),
                                    TextSpan(
                                      text: "${bookDetail?.lastChapter}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface.withAlpha(200),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 24,
                        bottom: 8,
                      ),
                      child: Text(
                        "书籍详情",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12, right: 12, bottom: 8),
                      child: Text(
                        bookDetail?.intro?.trim() ??
                            "这是一段用来撑开书籍详情骨架屏的占位文本，通常会包含书籍的简介、作者介绍等信息。",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 8 + MediaQuery.of(context).padding.bottom,
              right: 16,
              child: Row(
                children: [
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      minimumSize: Size(0, 42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement the onPressed callback
                    },
                    icon: SvgPicture.asset(
                      "assets/svg/ic_book_pages.svg",
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onPrimary,
                        BlendMode.srcIn,
                      ),
                      width: 20,
                    ),
                    label: Text("开始阅读"),
                  ),
                  IconButton.filled(
                    style: FilledButton.styleFrom(
                      minimumSize: Size(0, 42),
                      maximumSize: Size(42, 42),
                      padding: EdgeInsets.only(right: 12, left: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement the onPressed callback
                    },
                    icon: Icon(Icons.add, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
