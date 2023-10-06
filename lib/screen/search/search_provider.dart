import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/http/api.dart';
import 'package:xml/xml.dart';

part 'search_provider.freezed.dart';

@freezed
class Search with _$Search {
  const Search._();
  const factory Search({
    @Default(false) isLoading,
    @Default([]) List<String> names,
    @Default([]) List<String> authors,
    @Default(null) String? error,
  }) = _Search;
}

class SearchNotifier extends AutoDisposeNotifier<Search> {
  int page = 0;
  @override
  build() {
    return const Search();
  }

  // _parseBookMeta(List<XmlDocument?> res) {
  //   final List<BookItem> bookList = [];
  //   for (var element in res) {
  //     if (element == null) continue;
  //     var eles = element.findAllElements("data").toList();
  //     final aid = eles[0].getAttribute("aid")!;
  //     bookList.add(BookItem(
  //         aid: aid,
  //         name: eles[0].innerText,
  //         cover: Util.getCover(aid),
  //         author: eles[1].getAttribute("value"),
  //         status: eles[7].getAttribute("value"),
  //         lastUpdate: eles[9].getAttribute("value"),
  //         lastChapterId: eles[11].getAttribute("cid"),
  //         lastChapter: eles[11].innerText));
  //   }
  //   return bookList;
  // }

  _search(String key, searchFunc) async {
    List<String> bookAidList = [];
    XmlDocument? res = await searchFunc(key);
    if (res != null) {
      res.findAllElements("item").forEach((element) {
        bookAidList.add(element.getAttribute("aid")!);
      });
    }
    // var aidsRes = (await Future.wait(
    //     bookAidList.map((aid) => API.getNovelFullMeta(aid))));
    // return _parseBookMeta(aidsRes);
    return bookAidList;
  }

  init(String key) async {
    page = 0;
    state = const Search(isLoading: true);
    final names = await _search(key, API.searchNovelByNovelName);
    final authors = await _search(key, API.searchNovelByAuthorName);
    state =
        Search(names: names, authors: authors, isLoading: false, error: null);
  }
}

final searchProvider =
    NotifierProvider.autoDispose<SearchNotifier, Search>(SearchNotifier.new);
