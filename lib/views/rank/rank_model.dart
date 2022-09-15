import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../http/api.dart';
import '../../modals/list_book.dart';

final booksListProvider =
    StateNotifierProvider<BookListNotifier, List<ListBook>>((ref) {
  return BookListNotifier();
});

class BookListNotifier extends StateNotifier<List<ListBook>> {
  BookListNotifier() : super([]);
  int page = 1;

  void refresh(type) async {
    page = 1;
    var res = await API.getNovelList(type, page);
    state = res;
  }

  void loadMore(type) async {
    page++;
    var res = await API.getNovelList(type, page);
    state = [...state, ...res];
  }
}
