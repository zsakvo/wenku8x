import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/services/variable.dart';
import 'package:wenku8x/app/ui/components/loading/loading_indicator.dart';
import 'package:wenku8x/reader/providers/catalog.dart';
import 'package:wenku8x/reader/providers/menu_visible.dart';
import 'package:wenku8x/reader/services/provider.dart';

class MenuCatalog extends StatefulHookConsumerWidget {
  const MenuCatalog({super.key, this.bottomHeight = 52, required this.book});
  final double bottomHeight;
  final BookModel book;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuCatalogState();
}

class _MenuCatalogState extends ConsumerState<MenuCatalog> {
  @override
  Widget build(BuildContext context) {
    final menuState = ref.watch(ReaderProviderService().menuProvider_);
    final screenHeight = MediaQuery.of(context).size.height;
    final data = ref.watch(ReaderProviderService().catalogProvider_);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: 0,
      bottom: menuState.catalogVisible ? 0 : -screenHeight,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: screenHeight - 100,
        constraints: BoxConstraints(maxHeight: screenHeight),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: MediaQuery.removePadding(
          removeTop: true,
          removeBottom: true,
          context: context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                            "书籍ID：${widget.book.aid}",
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
                          color: Theme.of(context).colorScheme.surface,
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 6,
                            bottom: 4,
                          ),
                          // margin: EdgeInsets.only(bottom: 8),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: volume.title,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.tertiary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "\t\t\t共 ${volume.chapters.length} 章",
                                  style: TextStyle(
                                    fontSize: 12,
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
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final chapter = volume.chapters[index];
                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 0,
                              ),
                              visualDensity: VisualDensity.compact,
                              title: Text(chapter.title),
                              titleTextStyle: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              onTap: () {
                                // Handle chapter tap
                                logger.debug(
                                  "Tapped chapter: ${chapter.title} in volume: ${volume.title}",
                                );
                              },
                            );
                          }, childCount: volume.chapters.length),
                        ),
                      );
                    }).toList(),
                  ),
                  AsyncLoading() => Center(
                    child: Center(child: LoadingIndicator()),
                  ),
                  _ => Center(child: Text("加载目录失败，请稍后再试。")),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
