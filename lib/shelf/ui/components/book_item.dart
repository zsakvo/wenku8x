import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/libs/request/dio.dart';
import 'package:wenku8x/app/models/book.dart';

class BookItem extends StatefulHookConsumerWidget {
  final BookModel book;
  const BookItem({super.key, required this.book});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookItemState();
}

class _BookItemState extends ConsumerState<BookItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Handle book item tap
        },
        child: Container(
          height: 128,
          padding: const EdgeInsets.all(12),
          child: Row(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book cover image
              CachedNetworkImage(
                imageUrl: widget.book.coverUrl,
                width: 72,
                height: 108,
                fit: BoxFit.cover,
                httpHeaders: {"User-Agent": Ajax.UA},
              ),
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.book.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "上次更新：${widget.book.lastUpdate!}",
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(150),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "最新章节：${widget.book.lastChapter ?? "未知章节"}",
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(150),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
