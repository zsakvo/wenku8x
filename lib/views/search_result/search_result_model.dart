import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/modals/book_meta.dart';
import 'package:wenku8x/utils/log.dart';
import 'package:xml/xml.dart';

final searchListProvider =
    StateNotifierProvider.family<SearchLisrNotifier, List<BookMeta>, String>(
        (ref, keyword) {
  return SearchLisrNotifier(keyword);
});

class SearchLisrNotifier extends StateNotifier<List<BookMeta>> {
  final String keyword;
  SearchLisrNotifier(this.keyword) : super([]);
  void search() async {
    List bookAidList = [];
    final List<BookMeta> bookList = [];
    XmlDocument? authorRes = await API.searchNovelByAuthorName(keyword);
    XmlDocument? nameRes = await API.searchNovelByNovelName(keyword);
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
    var res =
        await Future.wait(bookAidList.map((aid) => API.getNovelFullMeta(aid)));
    for (var element in res) {
      var eles = element!.findAllElements("data").toList();
      Log.d(eles);
      bookList.add(BookMeta(
          aid: eles[0].getAttribute("aid"),
          title: eles[0].innerText,
          author: eles[1].getAttribute("value"),
          status: eles[7].getAttribute("value"),
          latestSection: eles[10].innerText));
    }
    state = bookList;
  }
}
