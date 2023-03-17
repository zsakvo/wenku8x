import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/utils/log.dart';

import '../../data/scheme/case_book.dart';
import '../../data/scheme/history_book.dart';

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
    var localAids = state.map((e) => e.aid).toSet();
    var remoteAids = res.map((e) => e.aid).toSet();
    var delAids = localAids.difference(remoteAids);
    var newAids = remoteAids.difference(localAids);
    state = [
      ...res.where((element) => newAids.contains(element.aid)),
      ...state.where((element) => !delAids.contains(element.aid))
    ];
    // if (res.isNotEmpty) {
    await isar!.writeTxn(() async {
      await isar!.caseBooks.clear();
      for (var element in state) {
        await isar!.caseBooks.put(element);
      }
    });
    // }
  }

  void addBook(CaseBook book) async {
    state = [book, ...state];
    await isar!.writeTxn(() async {
      await isar!.caseBooks.put(book);
    });
  }

  void delBook(dynamic aid) async {
    state = state.where((element) => element.aid != aid).toList();
    await isar!.writeTxn(() async {
      await isar!.caseBooks.filter().aidEqualTo(aid).deleteAll();
    });
  }

  void sortBooks(CaseBook book) {
    state = [book, ...state.where((element) => element.aid != book.aid)];
    isar!.writeTxnSync(() {
      isar!.caseBooks.clearSync();
      isar!.caseBooks.putAllSync(state.map((e) => CaseBook.fromJson(e.toJson())).toList());
    });
  }
}

final historyBooksListProvider = StateNotifierProvider<HistoryBookListNotifier, List<HistoryBook>>((ref) {
  return HistoryBookListNotifier();
});

class HistoryBookListNotifier extends StateNotifier<List<HistoryBook>> {
  Isar? isar;

  HistoryBookListNotifier() : super([]) {
    if (isar == null) {
      var isarInstance = Isar.getInstance();
      if (isarInstance == null) {
        isar = Isar.openSync([HistoryBookSchema]);
      } else {
        isar = isarInstance;
      }
    }
  }

  void addBook(HistoryBook book) async {
    if (state.indexWhere((element) => element.aid == book.aid) == -1) {
      state = [book, ...state];
      await isar!.writeTxn(() async {
        await isar!.historyBooks.put(book);
      });
    }
  }

  void delBook(dynamic aid) async {
    state = state.where((element) => element.aid != aid).toList();
    await isar!.writeTxn(() async {
      await isar!.historyBooks.filter().aidEqualTo(aid).deleteAll();
    });
  }

  void clear() async {
    state = [];
    await isar!.writeTxn(() async {
      await isar!.historyBooks.where().deleteAll();
    });
  }
}

final appLogProvider = StateNotifierProvider<AppLogNotifier, String>((ref) {
  return AppLogNotifier();
});

class AppLogNotifier extends StateNotifier<String> {
  AppLogNotifier() : super("");
  append(String log) {
    state += "\n\n$log";
  }
}
