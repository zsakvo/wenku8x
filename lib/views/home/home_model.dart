import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:wenku8x/http/api.dart';

import '../../data/scheme/case_book.dart';

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
  late final Isar isar;
  void refresh() async {
    var res = await API.getShelfBookList();
    state = res;
    isar.writeTxn(() async {
      for (var element in res) {
        await isar.caseBooks.put(element);
      }
    });
  }

  void init() async {
    isar = await Isar.open([CaseBookSchema]);
    state = isar.caseBooks.where().findAllSync();
  }
}
