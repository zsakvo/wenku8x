import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/modals/book_meta.dart';
import 'package:wenku8x/utils/log.dart';
import 'package:wenku8x/widgets/list_book.dart';
import 'package:xml/xml.dart';

enum SearchStatus { fetching, success, failed }

class SearchResultView extends StatefulHookConsumerWidget {
  final String keyword;
  const SearchResultView(this.keyword, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchResultViewState();
}

class _SearchResultViewState extends ConsumerState<SearchResultView> {
  @override
  Widget build(BuildContext context) {
    final searchStatus = useState(SearchStatus.fetching);
    final bookList = useState<List<BookMeta>>([]);

    searchBooks() async {
      try {
        List bookAidList = [];
        XmlDocument? authorRes =
            await API.searchNovelByAuthorName(widget.keyword);
        XmlDocument? nameRes = await API.searchNovelByNovelName(widget.keyword);
        if (authorRes != null) {
          authorRes.findAllElements("item").forEach((element) {
            bookAidList.add(element.getAttribute("aid"));
          });
        }
        if (nameRes != null) {
          nameRes.findAllElements("item").forEach((element) {
            bookAidList.add(element.getAttribute("aid"));
          });
        }
        var res = await Future.wait(
            bookAidList.map((aid) => API.getNovelFullMeta(aid)));
        for (var element in res) {
          var eles = element!.findAllElements("data").toList();
          bookList.value.add(BookMeta(
              aid: eles[0].getAttribute("aid"),
              title: eles[0].innerText,
              author: eles[1].getAttribute("value"),
              status: eles[7].getAttribute("value"),
              latestSection: eles[10].innerText));
        }
        searchStatus.value = SearchStatus.success;
      } catch (err) {
        Log.e(err);
        searchStatus.value = SearchStatus.failed;
      }
    }

    useFuture(useMemoized(() => searchBooks()));

    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            margin:
                const EdgeInsets.only(left: 32, right: 32, top: 20, bottom: 20),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.12),
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => GoRouter.of(context).pop(),
                    icon: const Icon(Icons.arrow_back)),
                Expanded(
                    child: Transform.translate(
                  offset: const Offset(0, -1),
                  child: Text(
                    widget.keyword,
                    style: const TextStyle(fontSize: 32),
                  ),
                )),
                IconButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          ),
          ...(() {
            switch (searchStatus.value) {
              case SearchStatus.fetching:
                return [
                  Expanded(
                      child: Material(
                    child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 6),
                        alignment: Alignment.center,
                        child: const SizedBox(
                          width: 84,
                          height: 84,
                          child: CircularProgressIndicator(),
                        )),
                  ))
                ];
              case SearchStatus.failed:
                return [
                  Expanded(
                      child: Material(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 6),
                      alignment: Alignment.center,
                      child: const Text('Error: 出错了'),
                    ),
                  ))
                ];
              case SearchStatus.success:
                return [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 24),
                    child: Text(
                      "共 ${bookList.value.length} 条搜索结果",
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: bookList.value.length,
                    shrinkWrap: true,
                    itemExtent: 230,
                    itemBuilder: (context, index) {
                      var book = bookList.value[index];
                      return ListBookTile(context,
                          cover: book.cover,
                          name: book.title!,
                          desc1: "${book.author} / ${book.status}",
                          desc2: "最新章节：${book.latestSection}", onTap: () {
                        GoRouter.of(context).push("/book_detail/${book.aid}");
                      });
                    },
                  ))
                ];
            }
          })()
        ],
      ),
    ));
  }
}
