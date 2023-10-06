import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/screen/reader/reader_provider.dart';

import '../../http/api.dart';

part 'home_provider.freezed.dart';
part 'home_provider.g.dart';

@Collection(ignore: {"catalog", "copyWith"})
@freezed
class BookItem with _$BookItem {
  const BookItem._();
  const factory BookItem({
    required String aid,
    required String name,
    String? cover,
    String? author,
    String? lastChapter,
    String? lastChapterId,
    String? lastUpdate,
    String? status,
    String? intro,
    List<Chapter>? catalog,
    @Default(false) bool isFav,
  }) = _BookItem;

  @Name("id")
  Id get id {
    return Isar.autoIncrement;
  }
}

const ranks = [
  {"icon": Icons.pan_tool_alt_outlined, "title": "点击"},
  {"icon": Icons.thumb_up_alt_outlined, "title": "推荐"},
  {"icon": Icons.file_open_outlined, "title": "收藏"},
  {"icon": Icons.edit_road_outlined, "title": "字数"},
  {"icon": Icons.school_outlined, "title": "完结"},
  {"icon": Icons.av_timer_outlined, "title": "新书"},
];

class MyBooksNotifier extends StateNotifier<List<BookItem>> {
  MyBooksNotifier() : super([]) {
    _initDB().then((_) => refresh());
  }

  late final Isar _isar;

  Future _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = Isar.openSync([BookItemSchema], directory: dir.path);
  }

  List<BookItem> _getBooksFromDB() {
    var res = _isar.bookItems.where().findAllSync().reversed.toList();
    return res;
  }

  void _writeBooksToDB() {
    final arr = state.reversed.toList();
    _isar.writeTxn(() async {
      await _isar.bookItems.clear();
      for (var element in arr) {
        await _isar.bookItems.put(element);
      }
    });
  }

  void refresh() async {
    // state = isar.myBooks.where().findAllSync();
    state = _getBooksFromDB();
    var res = await API.getShelfBookList();
    // var localAids = state.map((e) => e.aid).toSet();
    // var remoteAids = res.map((e) => e.aid).toSet();
    // var delAids = localAids.difference(remoteAids);
    // var newAids = remoteAids.difference(localAids);
    // state = [
    //   ...res.where((element) => newAids.contains(element.aid)),
    //   ...state.where((element) => !delAids.contains(element.aid))
    // ];
    if (res != null) {
      state = res;
      _writeBooksToDB();
    }
  }

  void addBook(BookItem book) {
    API.addToBookShelf(book.aid);
    state = [book, ...state];
    // _writeBooksToDB();
    _isar.writeTxn(() async {
      await _isar.bookItems.put(book);
    });
  }

  void delBook(String aid) {
    API.removeFromBookShelf(aid);
    state = state.where((element) => element.aid != aid).toList();
    _isar.writeTxn(() async {
      await _isar.bookItems.filter().aidEqualTo(aid).deleteFirst();
    });
  }
}

final myBooksProvider =
    StateNotifierProvider<MyBooksNotifier, List<BookItem>>((ref) {
  return MyBooksNotifier();
});
