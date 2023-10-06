import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/home/home_provider.dart';
import 'package:wenku8x/service/navigation.dart';

class BookItemComp extends StatefulHookConsumerWidget {
  const BookItemComp(
    this.bookItem, {
    super.key,
    this.onItemTap,
    this.onItemLongTap,
  });

  final BookItem bookItem;

  final Function(BookItem bookItem)? onItemTap;
  final Function(BookItem bookItem)? onItemLongTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookItemCompState();
}

class _BookItemCompState extends ConsumerState<BookItemComp>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colorScheme = getColorScheme(context);
    return InkWell(
      // 隐藏点击效果
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: widget.onItemTap != null
          ? () => widget.onItemTap!(widget.bookItem)
          : null,
      onLongPress: widget.onItemLongTap != null
          ? () => widget.onItemLongTap!(widget.bookItem)
          : null,
      child: Container(
          padding: const EdgeInsets.only(left: 16, bottom: 20, right: 16),
          child: Row(children: [
            Container(
              width: 64,
              height: 86,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: getColorScheme(context).surfaceVariant),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: widget.bookItem.cover!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  constraints: const BoxConstraints(minHeight: 86),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.bookItem.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 6),
                        child: Text(
                          widget.bookItem.author ??
                              "上次更新：${widget.bookItem.lastUpdate!}",
                          style: TextStyle(
                              fontSize: 13,
                              color: colorScheme.onSurface.withOpacity(0.6)),
                        ),
                      ),
                      Text(
                        widget.bookItem.lastChapter ?? "暂无更新",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurface.withOpacity(0.6)),
                      ),
                    ],
                  )),
            )
          ])),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
