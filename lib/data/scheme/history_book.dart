import 'dart:convert';

import 'package:isar/isar.dart';

part 'history_book.g.dart';

@collection
class HistoryBook {
  Id id = Isar.autoIncrement;
  final String bookName;
  String updateTime;
  final String aid;
  final String cover;
  String lastChapter;

  HistoryBook(this.bookName, this.aid, this.cover, this.updateTime, this.lastChapter);

  Map<String, dynamic> toMap() {
    return {'bookName': bookName, 'aid': aid, 'cover': cover, 'updateTime': updateTime, 'lastChapter': lastChapter};
  }

  factory HistoryBook.fromMap(Map<String, dynamic> map) {
    return HistoryBook(
      map['bookName'] ?? '',
      map['aid'] ?? '',
      map['cover'] ?? '',
      map['updateTime'] ?? '',
      map['lastChapter'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryBook.fromJson(String source) => HistoryBook.fromMap(json.decode(source));
}
