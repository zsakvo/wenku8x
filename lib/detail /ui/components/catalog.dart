import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/services/variable.dart';
import 'package:wenku8x/detail%20/providers/catalog.dart';

class BookDetailCatalog extends StatefulHookConsumerWidget {
  const BookDetailCatalog({super.key, required this.book});
  final BookModel book;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BookDetailCatalogState();
}

class _BookDetailCatalogState extends ConsumerState<BookDetailCatalog> {
  final logger = Logger("BookDetailCatalog");
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(catalogProvider(widget.book.aid));
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: Column(
        spacing: 12,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              spacing: 16,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.book.coverUrl,
                  width: 64,
                  height: 90,
                  fit: BoxFit.cover,
                  httpHeaders: {"User-Agent": VariableService().UserAgent},
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        widget.book.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${widget.book.author!} / ${widget.book.status!}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(150),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: switch (data) {
              AsyncValue(:final value, hasValue: true) => CustomScrollView(
                slivers: value!.volumes.map((volume) {
                  return SliverStickyHeader(
                    header: Container(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      margin: EdgeInsets.only(bottom: 8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: volume.title,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withAlpha(200),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "\t\t\t共 ${volume.chapters.length} 章",
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withAlpha(150),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final chapter = volume.chapters[index];
                        return ListTile(
                          visualDensity: VisualDensity.compact,
                          title: Text(chapter.title),
                          titleTextStyle: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          onTap: () {
                            // Handle chapter tap
                          },
                        );
                      }, childCount: volume.chapters.length),
                    ),
                  );
                }).toList(),
              ),
              _ => Center(child: Text("加载目录失败，请稍后再试。")),
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
