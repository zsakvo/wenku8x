import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/discover/models/discover.dart';

part 'discover.g.dart';

@riverpod
class DiscoverFilter extends _$DiscoverFilter {
  @override
  DiscoverModel build() {
    return DiscoverModel();
  }

  void setType(String type) {
    final subs = novelSort[type]?["subs"] as List<Map<String, dynamic>>?;
    final flag =
        subs?.first["flag"] as String? ?? novelSort[type]?["flag"] as String;
    state = state.copyWith(type: type, flag: flag);
  }

  void setFlag(String flag) {
    state = state.copyWith(flag: flag);
  }
}

@riverpod
class DiscoverData extends _$DiscoverData {
  @override
  PagingState<int, BookModel> build() {
    ref.listen(discoverFilterProvider, (previous, next) {
      if (previous?.flag != next.flag) {
        // ref.invalidateSelf();
        refresh_books();
      }
    });
    // final discover = ref.read(discoverFilterProvider);
    // return await Api.getNovelList(discover.flag, 1) ?? [];
    return PagingState<int, BookModel>(isLoading: true, error: null);
  }

  // Future<void> refresh() async {
  //   ref.invalidateSelf();
  // }

  refresh_books() async {
    final discover = ref.read(discoverFilterProvider);
    state = state.copyWith(
      error: null,
      isLoading: true,
      pages: null,
      keys: null,
    );
    final books = await Future.any<List<BookModel>>([
      Api.getNovelList(discover.flag, 1).then((value) => value ?? []),
      Future.delayed(const Duration(milliseconds: 500), () => []),
    ]);
    final newKey = (state.keys?.last ?? 0) + 1;
    state = state.copyWith(
      pages: [...?state.pages, books],
      keys: [...?state.keys, newKey],
      hasNextPage: books.isNotEmpty,
      isLoading: false,
    );
  }

  next_page() async {
    final discover = ref.read(discoverFilterProvider);
    final pageKey = (state.keys?.last ?? 0) + 1;
    final books = await Api.getNovelList(discover.flag, pageKey) ?? [];
    if (books.isEmpty) {
      state = state.copyWith(hasNextPage: false);
      return;
    }
    final newKey = pageKey + 1;
    state = state.copyWith(
      pages: [...?state.pages, books],
      keys: [...?state.keys, newKey],
      hasNextPage: true,
      isLoading: false,
    );
  }
}

// @riverpod
// class DiscoverAll extends _$DiscoverAll {
//   @override
//   FutureOr<DiscoverModel> build() async {
//     return DiscoverModel();
//   }

//   _fetchBooks() async {
//     final data = await Api.getNovelList(state.asData!.value.flag, 1) ?? [];
//     return model.copyWith(data: data);
//   }

//   // @override
//   // FutureOr<List<Map<String, dynamic>>> build() async {
//   //   final results = await Future.wait(
//   //     novelSort.entries.map((entry) async {
//   //       final sortData = entry.value;
//   //       final flag =
//   //           sortData['flag'] as String? ??
//   //           (sortData['subs'] as List<Map<String, dynamic>>)[0]['flag']
//   //               as String;
//   //       return Api.getNovelList(flag, 1);
//   //     }),
//   //   );
//   //   return results
//   //       .mapIndexed((index, result) {
//   //         final value = novelSort.entries.elementAt(index).value;
//   //         return {
//   //           'title': value['title'],
//   //           'data': result!.take(6).toList(),
//   //           'color': generateColorFromString(value['title'] as String),
//   //         };
//   //       })
//   //       .toList()
//   //       .reversed
//   //       .toList();
//   // }

//   // Future<void> refresh() async {
//   //   ref.invalidateSelf();
//   // }
// }
