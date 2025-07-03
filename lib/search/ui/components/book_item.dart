import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/services/variable.dart';

class BookItem extends StatefulHookConsumerWidget {
  const BookItem({super.key, required this.book, this.onTap});
  final BookModel book;
  final Function(BookModel book)? onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookItemState();
}

class _BookItemState extends ConsumerState<BookItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => widget.onTap?.call(widget.book),
        child: Container(
          height: 118,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            spacing: 16,
            children: [
              CachedNetworkImage(
                imageUrl: widget.book.coverUrl,
                httpHeaders: {"User-Agent": VariableService().UserAgent},
                width: 64,
              ),
              Expanded(
                child: Column(
                  spacing: 6,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      "${widget.book.author!}\t\t/\t\t${widget.book.status!}",
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: widget.book.tags!.take(4).map((tag) {
                        return Container(
                          margin: const EdgeInsets.only(right: 4, top: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 12,
                              height: 1,
                              color: Colors.grey[800],
                            ),
                          ),
                        );
                      }).toList(),
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
