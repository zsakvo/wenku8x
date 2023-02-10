import 'dart:convert';

import 'package:isar/isar.dart';

part 'case_book.g.dart';

@collection
class CaseBook {
  Id id = Isar.autoIncrement;
  final String bookName;
  String updateTime;
  final String aid;
  String cid;
  int cIndex;
  int page;
  final String cover;
  String? lastRead;
  String lastChapter;

  CaseBook(
    this.bookName,
    this.aid,
    this.cid,
    this.cIndex,
    this.page,
    this.cover,
    this.updateTime,
    this.lastChapter, {
    this.lastRead,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookName': bookName,
      'aid': aid,
      'cid': cid,
      'cIndex': cIndex,
      'page': page,
      'cover': cover,
      'updateTime': updateTime,
      'lastRead': lastRead,
      'lastChapter': lastChapter
    };
  }

  factory CaseBook.fromMap(Map<String, dynamic> map) {
    return CaseBook(
      map['bookName'] ?? '',
      map['aid'] ?? '',
      map['cid'] ?? '',
      map['cIndex'] ?? 0,
      map['page'] ?? 0,
      map['cover'] ?? '',
      map['updateTime'] ?? '',
      map['lastChapter'] ?? '',
      lastRead: map['lastRead'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CaseBook.fromJson(String source) => CaseBook.fromMap(json.decode(source));
}
