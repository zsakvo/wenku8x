import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/utils/color.dart';

part 'discover.g.dart';

final novelSort = {
  "visit": {
    "title": "点击榜",
    "subs": [
      {"title": "总榜", "flag": "allvisit"},
      {"title": "月榜", "flag": "monthvisit"},
      {"title": "周榜", "flag": "weekvisit"},
      {"title": "日榜", "flag": "dayvisit"},
    ],
  },
  "vote": {
    "title": "推荐榜",
    "subs": [
      {"title": "总榜", "flag": "allvote"},
      {"title": "月榜", "flag": "monthvote"},
      {"title": "周榜", "flag": "weekvote"},
      {"title": "日榜", "flag": "dayvote"},
    ],
  },
  "postdate": {"title": "最新入库", "flag": "postdate"},
  "lastupdate": {"title": "最近更新", "flag": "lastupdate"},
  "goodnum": {"title": "收藏排行", "flag": "goodnum"},
  "size": {"title": "字数排行", "flag": "size"},
  "fullflag": {"title": "完结小说", "flag": "fullflag"},
};

@riverpod
class DiscoverAll extends _$DiscoverAll {
  @override
  FutureOr<List<Map<String, dynamic>>> build() async {
    final results = await Future.wait(
      novelSort.entries.map((entry) async {
        final sortData = entry.value;
        final flag =
            sortData['flag'] as String? ??
            (sortData['subs'] as List<Map<String, dynamic>>)[0]['flag']
                as String;
        return Api.getNovelList(flag, 1);
      }),
    );
    return results
        .mapIndexed((index, result) {
          final value = novelSort.entries.elementAt(index).value;
          return {
            'title': value['title'],
            'data': result!.take(6).toList(),
            'color': generateColorFromString(value['title'] as String),
          };
        })
        .toList()
        .reversed
        .toList();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
