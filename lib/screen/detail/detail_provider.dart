import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/screen/home/home_provider.dart';
import 'package:wenku8x/screen/reader/reader_provider.dart';
import 'package:wenku8x/utils/util.dart';
import 'package:xml/xml.dart';

class DetailNotifier extends AutoDisposeFamilyNotifier<BookItem, BookItem> {
  @override
  build(arg) {
    Future.delayed(const Duration(milliseconds: 300)).then((_) async {
      String intro = await _getIntro(arg.aid);
      List<Chapter> catalog = await _getCatalog(arg.aid);
      BookItem bookItem = await _getMeta(bookItem: arg);
      state = bookItem.copyWith(intro: intro, catalog: catalog);
    });
    return arg;
  }

  _getIntro(aid) async {
    return await API.getNovelFullIntro(aid);
  }

  _getMeta({required BookItem bookItem}) async {
    final value = await API.getNovelFullMeta(bookItem.aid);
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
      return bookItem;
    }
  }

  Future<List<Chapter>> _getCatalog(aid) async {
    return await API.getNovelIndex(aid);
  }
}

final detailProvider = NotifierProvider.autoDispose
    .family<DetailNotifier, BookItem, BookItem>(DetailNotifier.new);
