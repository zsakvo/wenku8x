import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../reader_provider.dart';

class MenuCatalog extends StatefulHookConsumerWidget {
  const MenuCatalog(this.provider, {super.key});
  final dynamic provider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuCatalogState();
}

class _MenuCatalogState extends ConsumerState<MenuCatalog>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bottomPos = useState(-height);
    // final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final scrollController = useScrollController(keepScrollOffset: true);
    final reader = ref.watch(widget.provider);
    final state = ref.watch(
        readerMenuStateProvider.select((value) => value.menuCatalogVisible));
    final bottomHeight = ref.watch(
        readerMenuStateProvider.select((value) => value.bottomBarHeight));
    useEffect(() {
      if (state) {
        scrollController.jumpTo(reader.cIndex * 46.0);
      }
      return null;
    }, [state]);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        bottomPos.value = -context.findRenderObject()!.paintBounds.size.height;
      });
      return null;
    }, []);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      left: 0,
      bottom: state ? bottomHeight : bottomPos.value,
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - bottomHeight - 64),
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
              child: Text(
                "目录",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
                child: MediaQuery.removePadding(
                    removeTop: true,
                    removeBottom: true,
                    context: context,
                    child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        controller: scrollController,
                        cacheExtent: 46,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const SizedBox(
                              height: 1,
                            );
                          } else {
                            final chapter = reader.catalog[index - 1];
                            return InkWell(
                              onTap: () {
                                ref
                                    .read(widget.provider.notifier)
                                    .jumpToIndex(index - 1);
                                // return;
                                // widget.onItemTap(index - 1, chapter);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Text(
                                  chapter.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: (index - 1) == reader.cIndex
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                      fontSize: 13),
                                ),
                              ),
                            );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            indent: 16,
                            endIndent: 16,
                            height: 0,
                            thickness: 0.4,
                            color: Theme.of(context).colorScheme.outline,
                          );
                        },
                        itemCount: reader.catalog.length + 1)))
          ],
        ),
      ),
    );
  }
}
