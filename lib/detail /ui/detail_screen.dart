import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/services/variable.dart';
import 'package:wenku8x/app/ui/components/top_bar.dart';
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
    return Scaffold(
      appBar: AppTopBar(title: "书籍详情"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                "这是一行占位使用的文本",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(164),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: DottedBorder(
                options: RectDottedBorderOptions(
                  padding: EdgeInsets.all(8),
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
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
                    CachedNetworkImage(
                      imageUrl: widget.book.coverUrl,
                      width: 56,
                      height: 82,
                      fit: BoxFit.cover,
                      httpHeaders: {"User-Agent": VariableService().UserAgent},
                    ),
                    Expanded(
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.book.name,
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
                                  text: "\t\t${widget.book.author!}",
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
          ],
        ),
      ),
    );
  }
}
