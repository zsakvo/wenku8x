import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/screen/home/home_provider.dart';
import 'package:wenku8x/utils/util.dart';
import 'package:xml/xml.dart';

part 'rank_provider.freezed.dart';

final novelSort = {
  "visit": {
    "title": "点击榜",
    "subs": [
      {
        "title": "总榜",
        "flag": "allvisit",
      },
      {
        "title": "月榜",
        "flag": "monthvisit",
      },
      {
        "title": "周榜",
        "flag": "weekvisit",
      },
      {
        "title": "日榜",
        "flag": "dayvisit",
      }
    ]
  },
  "vote": {
    "title": "推荐榜",
    "subs": [
      {
        "title": "总榜",
        "flag": "allvote",
      },
      {
        "title": "月榜",
        "flag": "monthvote",
      },
      {
        "title": "周榜",
        "flag": "weekvote",
      },
      {
        "title": "日榜",
        "flag": "dayvote",
      }
    ]
  },
  "postdate": {
    "title": "最新入库",
    "flag": "postdate",
  },
  "lastupdate": {
    "title": "最近更新",
    "flag": "lastupdate",
  },
  "goodnum": {
    "title": "收藏排行",
    "flag": "goodnum",
  },
  "size": {
    "title": "字数排行",
    "flag": "size",
  },
  "fullflag": {
    "title": "完结小说",
    "flag": "fullflag",
  },
};

@freezed
class Rank with _$Rank {
  const Rank._();
  const factory Rank({
    required String flag,
    @Default([]) List<BookItem> books,
    @Default(0) int subIndex,
  }) = _Rank;

  String get title {
    return novelSort[flag]!["title"] as String;
  }

  List<Map<String, dynamic>>? get subs {
    return novelSort[flag]!["subs"] as List<Map<String, dynamic>>?;
  }

  String get sortFlag {
    return subs == null ? flag : subs![subIndex]['flag'] as String;
  }
}

class RankNotifier extends AutoDisposeFamilyNotifier<Rank, String> {
  int page = 1;
  @override
  build(arg) {
    return Rank(flag: arg);
  }

  init() {
    page = 1;
    state = state.copyWith(books: []);
    _getBooks();
  }

  loadMore() async {
    page++;
    await _getBooks();
  }

  updateSub(String sub) {
    state = state.copyWith(books: []);
    final index = state.subs!.indexWhere((element) => element["flag"] == sub);
    state = state.copyWith(subIndex: index);
  }

  _getBooks() async {
    var res = await API.getNovelList(state.sortFlag, page);
    if (res != null) {
      var books = _parseBook(res);
      state = state.copyWith(books: [...state.books, ...books]);
    }
  }

  _parseBook(XmlDocument res) {
    return res.findAllElements("item").map((element) {
      var elements =
          element.children.where((p0) => p0.toString().length > 2).toList();
      final aid = element.getAttribute("aid")!;
      return BookItem(
          aid: aid,
          cover: Util.getCover(aid),
          name: elements[0].innerText,
          author: elements[4].getAttribute("value").toString(),
          status: elements[5].getAttribute("value").toString(),
          lastUpdate: elements[6].getAttribute("value").toString());
      // intro: elements[7].innerText.replaceAll("\n", ""));
    });
  }
}

final rankProvider = NotifierProvider.family
    .autoDispose<RankNotifier, Rank, String>(RankNotifier.new);
