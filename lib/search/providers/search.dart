import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/book.dart';

part 'search.g.dart';

enum SearchType { name, author }

Map<SearchType, String> searchTypes = <SearchType, String>{
  SearchType.name: "书名",
  SearchType.author: "作者",
};

final logger = Logger("SearchFilter");

@riverpod
class SearchFilter extends _$SearchFilter {
  SearchType _type = SearchType.name;

  @override
  FutureOr<List<BookModel>> build(String searchKey) async {
    _search();
    return [];
  }

  void setType(SearchType type) {
    if (_type != type) {
      _type = type;
      _search();
    }
  }

  void _search() {
    state = const AsyncValue.loading();
    final searchFn = _type == SearchType.name
        ? Api.searchNovelByNovelName
        : Api.searchNovelByAuthorName;

    searchFn(searchKey).then((result) {
      // 处理搜索结果
      logger.debug("Search results for $searchKey: $result");
      state = AsyncValue.data(result);
    });
  }
}
