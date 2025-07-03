import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/services/variable.dart';

class BookItem extends StatefulHookConsumerWidget {
  const BookItem({super.key, required this.book});
  final BookModel book;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookItemState();
}

class _BookItemState extends ConsumerState<BookItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.book.name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.book.author!,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
