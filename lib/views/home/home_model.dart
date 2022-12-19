import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/modals/case_book.dart';
import 'package:wenku8x/utils/log.dart';

final drawerToggleProvider = StateNotifierProvider((ref) {
  return DrawerToggle();
});

class DrawerToggle extends StateNotifier<bool> {
  DrawerToggle() : super(false);

  void toogle() => !state;
}

final booksListProvider = StateNotifierProvider<BookListNotifier, List<CaseBook>>((ref) {
  return BookListNotifier();
});

class BookListNotifier extends StateNotifier<List<CaseBook>> {
  BookListNotifier() : super([]);
  void refresh() async {
    var res = await API.getShelfBookList();
    state = res;
  }
}
