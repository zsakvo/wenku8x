import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/screen/home/home_provider.dart';
import 'package:wenku8x/service/navigation.dart';
import 'package:wenku8x/utils/util.dart';
import 'package:xml/xml.dart';

class BookItemComp extends StatefulHookConsumerWidget {
  const BookItemComp(this.aid, {super.key, this.onItemTap});

  // final BookItem bookItem;
  final String aid;

  final Function(BookItem bookItem)? onItemTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookItemCompState();
}

class _BookItemCompState extends ConsumerState<BookItemComp>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colorScheme = getColorScheme(context);
    final cover = Util.getCover(widget.aid);
    final bookItem = ref.watch(bookItemProvider(widget.aid));
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (widget.onItemTap != null && bookItem.hasValue) {
          widget.onItemTap!(bookItem.value!);
        }
      },
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
                  imageUrl: cover,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            bookItem.when(
              data: (data) {
                return Expanded(
                  child: Container(
                      constraints: const BoxConstraints(minHeight: 86),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.name,
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
                              "${data.author!}\t/\t${data.status!}",
                              style: TextStyle(
                                  fontSize: 13,
                                  color:
                                      colorScheme.onSurface.withOpacity(0.6)),
                            ),
                          ),
                          Text(
                            data.lastChapter!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13,
                                color: colorScheme.onSurface.withOpacity(0.6)),
                          ),
                        ],
                      )),
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return const Center(
                  child: SizedBox(
                      width: 96, height: 3, child: LinearProgressIndicator()),
                );
              },
            )
          ])),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

final bookItemProvider =
    AutoDisposeFutureProvider.family<BookItem, String>((ref, aid) async {
  return API.getNovelFullMeta(aid).then((value) {
    if (value != null) {
      var eles = value.findAllElements("data").toList();
      final aid = eles[0].getAttribute("aid")!;
      return BookItem(
          aid: aid,
          name: eles[0].innerText,
          cover: Util.getCover(aid),
          author: eles[1].getAttribute("value"),
          status: eles[7].getAttribute("value"),
          lastUpdate: eles[9].getAttribute("value"),
          lastChapterId: eles[11].getAttribute("cid"),
          lastChapter: eles[11].innerText);
    } else {
      return BookItem(aid: aid, name: "加载失败");
    }
  });
});
