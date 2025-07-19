import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/services/variable.dart';

class BookItem extends StatefulHookConsumerWidget {
  final BookModel book;
  final Function(BookModel book)? onTap;
  const BookItem({super.key, required this.book, this.onTap});

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
          widget.onTap?.call(widget.book);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Book cover image
              CachedNetworkImage(
                imageUrl: widget.book.coverUrl,
                width: 54,
                height: 72,
                fit: BoxFit.cover,
                httpHeaders: {"User-Agent": VariableService().UserAgent},
              ),
              Expanded(
                child: Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.book.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        Text(
                          widget.book.author!,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlpha(150),
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerLowest,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Text(
                            "${widget.book.status}",
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
                      ],
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
