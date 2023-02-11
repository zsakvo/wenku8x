import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/utils/log.dart';

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
  Isar? isar;
  // final Isar isar = Isar.openSync([CaseBookSchema]);
  void refresh() async {
    if (isar == null) {
      var isarInstance = Isar.getInstance();
      if (isarInstance == null) {
        isar = Isar.openSync([CaseBookSchema]);
      } else {
        isar = isarInstance;
      }
    }
    state = isar!.caseBooks.where().findAllSync();
    var res = await API.getShelfBookList();
    state = res;
    if (res.isNotEmpty) {
      await isar!.writeTxn(() async {
        await isar!.caseBooks.clear();
        for (var element in res) {
          await isar!.caseBooks.put(element);
        }
      });
    }
  }
}
