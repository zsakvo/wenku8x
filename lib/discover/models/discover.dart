import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wenku8x/app/models/book.dart';

part 'discover.g.dart';
part 'discover.freezed.dart';

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

@freezed
abstract class DiscoverModel with _$DiscoverModel {
  const factory DiscoverModel({
    @Default("visit") String type,
    @Default("allvisit") String flag,
  }) = _DiscoverModel;

  factory DiscoverModel.fromJson(Map<String, dynamic> json) =>
      _$DiscoverModelFromJson(json);

  const DiscoverModel._();

  String get typeName => novelSort[type]!["title"] as String;

  String? get flagName {
    final subs = novelSort[type]?["subs"] as List<Map<String, dynamic>>?;
    if (subs != null) {
      return subs.firstWhere((e) => e["flag"] == flag)["title"] as String;
    }
    return null;
  }
}
